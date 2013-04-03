/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  ISOS
//
//  Created by shishir on 12/10/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ISOSPushNotifyPlugin.h"
#import "ISOSGeofencingLoationUpdates.h"
#ifdef CORDOVA_FRAMEWORK
    #import <Cordova/CDVPlugin.h>
    #import <Cordova/CDVURLProtocol.h>
#else
    #import "CDVPlugin.h"
    #import "CDVURLProtocol.h"
#endif
#import <Cordova/CDVURLProtocol.h>



@implementation AppDelegate

@synthesize window, viewController,arrayNotification,progressController;
NSString * const NSURLIsExcludedFromBackupKey =@"NSURLIsExcludedFromBackupKey";
- (id) init
{		
    /** If you need to do any extra app-specific initialization, you can do it here
     *  -jm
     **/
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    self = [super init];
    return self;
}

#pragma UIApplicationDelegate implementation

/**
 * This is main kick off after the app inits, the views and Settings are setup here. (preferred - iOS4 and up)
 */
- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    progressController = [[ProgressController alloc]init];
    [progressController setProgressString:@"Loading"];
    
    NSURL* url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    NSString* invokeString = nil;
    
    if (url && [url isKindOfClass:[NSURL class]]) {
        invokeString = [url absoluteString];
    }
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[[UIWindow alloc] initWithFrame:screenBounds] autorelease];
    self.window.autoresizesSubviews = YES;
    
    CGRect viewBounds = [[UIScreen mainScreen] applicationFrame];
    
    self.viewController = [[[MainViewController alloc] init] autorelease];
    self.viewController.useSplashScreen = YES;
    self.viewController.wwwFolderName = @"www";
    self.viewController.startPage = @"index.html";
    //self.viewController.invokeString = invokeString;
    self.viewController.view.frame = viewBounds;
    self.viewController.webView.scrollView.scrollEnabled=NO;
    
    // check whether the current orientation is supported: if it is, keep it, rather than forcing a rotation
    BOOL forceStartupRotation = YES;
    UIDeviceOrientation curDevOrientation = [[UIDevice currentDevice] orientation];
    
    /*if (UIDeviceOrientationUnknown == curDevOrientation) {
        // UIDevice isn't firing orientation notifications yet… go look at the status bar
        curDevOrientation = (UIDeviceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    }
    
    if (UIDeviceOrientationIsValidInterfaceOrientation(curDevOrientation)) {
        for (NSNumber *orient in self.viewController.supportedOrientations) {
            if ([orient intValue] == curDevOrientation) {
                forceStartupRotation = NO;
                break;
            }
        }
    } 
    
    if (forceStartupRotation) {
        // The first item in the supportedOrientations array is the start orientation (guaranteed to be at least Portrait)
        UIInterfaceOrientation newOrient = [[self.viewController.supportedOrientations objectAtIndex:0] intValue];
        [[UIApplication sharedApplication] setStatusBarOrientation:newOrient];
    }*/
    
    //[self.window addSubview:self.viewController.view];
    //[self.window makeKeyAndVisible];
    
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    //Allocation for array notification
    self.arrayNotification=[NSMutableArray array];
    
    /*
     * Application is launched from remote notification received
     */
    if([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey])
    {
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        NSString *str = [NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.alert"]];
        NSArray *payload = [str componentsSeparatedByString:@"$$"];
        
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init]autorelease];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ssZZZ"];
        
        NSTimeInterval timestamp = [[payload objectAtIndex:1]doubleValue];
        NSDate *notificationDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
        
        NSMutableDictionary *alerDict = [NSMutableDictionary dictionary];
        [alerDict setObject:[payload objectAtIndex:0] forKey:@"Message"];
        [alerDict setObject:[dateFormatter stringFromDate:notificationDate] forKey:@"Date"];
        
        ISOSPushNotifyPlugin *pushHandler = [self.viewController getCommandInstance:@"com.isos.RegisterDevice"];
        [self.arrayNotification addObject:alerDict];
        pushHandler.notificationMessageArray=self.arrayNotification;
        [pushHandler notificationReceived];
    }
    
    
    //Handle Push Notification 
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    return YES;
}

// this happens while we are running ( in the background, or from within our own app )
// only valid if ISOS-Info.plist specifies a protocol to handle
- (BOOL) application:(UIApplication*)application handleOpenURL:(NSURL*)url 
{
    if (!url) { 
        return NO; 
    }
    
	// calls into javascript global function 'handleOpenURL'
    NSString* jsString = [NSString stringWithFormat:@"handleOpenURL(\"%@\");", url];
    [self.viewController.webView stringByEvaluatingJavaScriptFromString:jsString];
    
    // all plugins will get the notification, and their handlers will be called 
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];
    
    return YES;    
}

- (void)applicationDidBecomeActive:(UIApplication *)application{

    [progressController removeProgressBar]; //  hides progress indicator
}

#pragma mark Implement Apple Push Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"What Up");
    
    NSString *strToken = [[[[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    ISOSPushNotifyPlugin *pushHandler=[self.viewController getCommandInstance:@"com.isos.RegisterDevice"];
    [pushHandler didRegisterForRemoteNotificationsWithDeviceToken:strToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"errors: %@", [error localizedDescription]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    UIAlertView *notification_alert = [[UIAlertView alloc]initWithTitle:@"International SOS" message:@"Hello this is a test" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [notification_alert show];
    [notification_alert release];
    
    NSString *str = [NSString stringWithFormat:@"%@",[userInfo valueForKeyPath:@"aps.alert"]];
    NSArray *payload = [str componentsSeparatedByString:@"$$"];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init]autorelease];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ssZZZ"];

    NSTimeInterval timestamp = [[payload objectAtIndex:1]doubleValue];
    NSDate *notificationDate = [NSDate dateWithTimeIntervalSince1970:timestamp];

    NSMutableDictionary *alerDict = [NSMutableDictionary dictionary];
    [alerDict setObject:[payload objectAtIndex:0] forKey:@"Message"];
    [alerDict setObject:[dateFormatter stringFromDate:notificationDate] forKey:@"Date"];
    
    //  --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    //  HP: 05Nov2012   //  Check state of the app and show alert accordingly
    //  --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if (application.applicationState==UIApplicationStateActive) {
        UIAlertView *notification_alert = [[UIAlertView alloc]initWithTitle:@"International SOS" message:[NSString stringWithFormat:@"%@",[payload objectAtIndex:0]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [notification_alert show];
        [notification_alert release];
    }
    //  --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    
    ISOSPushNotifyPlugin *pushHandler = [self.viewController getCommandInstance:@"com.isos.RegisterDevice"];
    [self.arrayNotification addObject:alerDict];
    pushHandler.notificationMessageArray=self.arrayNotification;
    [pushHandler notificationReceived];
}

-(void)dealloc
{
    [arrayNotification release];
    [progressController release];
    [super dealloc];
}

@end
