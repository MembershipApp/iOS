//
//  ISOSPushNotifyPlugin.h
//  ISOSPhonegapPushNotification
//
//  Created by shishir on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface ISOSPushNotifyPlugin : CDVPlugin
{
    NSString *deviceTokenString;    //  Device token string
    NSMutableArray *notificationMessageArray;   //  Array that holds push notifications received from server in JSON format
}
@property(readwrite,retain) NSMutableArray *notificationMessageArray;
@property(nonatomic,retain)NSString *deviceTokenString;

/*
 * registerDevice:arguments withDict:options
 * Discussion:
 * Invoked to pass device token to native code to register with APNs
 */
- (void)registerDevice:(NSMutableArray *)arguments withDict:(NSMutableDictionary*)options;
/*
 * didRegisterForRemoteNotificationsWithDeviceToken:deviceToken
 * Discussion:
 * Acknowledgement of device token registration
 */
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSString*)deviceToken;

/*
 * notificationReceived
 * Discussion:
 * Invoked when remote push notification is received
 */
- (void)notificationReceived;

@end
