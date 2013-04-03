//
//  ISOSPushNotifyPlugin.m
//  ISOSPhonegapPushNotification
//
//  Created by shishir on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ISOSPushNotifyPlugin.h"
#import <Cordova/JSONKit.h>
#import "AppDelegate.h"
#import "JSONClasses/JSON.h"

@implementation ISOSPushNotifyPlugin
@synthesize deviceTokenString,notificationMessageArray;

//get token from APN server
- (void)registerDevice:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString *callbackId = [arguments pop];
    
    NSString *resultType = [arguments objectAtIndex:0]; 
   
    CDVPluginResult *result;
    if ( [resultType isEqualToString:@"token"] ) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: deviceTokenString];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
}
//save token 
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSString*)deviceToken{
    self.deviceTokenString= (NSString *)[[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                    stringByReplacingOccurrencesOfString:@">" withString:@""]
                                   stringByReplacingOccurrencesOfString: @" " withString: @""];
    
}

//reecived userinfo from app delegate
- (void)notificationReceived{
    
    NSString *jsStatement = [NSString stringWithFormat:@"notificationCallback('%@')",[notificationMessageArray JSONRepresentation]];
    [self writeJavascript:jsStatement];
}


@end
