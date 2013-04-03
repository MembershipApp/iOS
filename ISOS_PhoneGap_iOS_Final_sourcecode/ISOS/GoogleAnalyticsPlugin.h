//
//  GoogleAnalyticsPlugin.h
//  ISOS
//
//  Created by shishir on 22/10/12.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "GANTracker.h"
@interface GoogleAnalyticsPlugin : CDVPlugin<GANTrackerDelegate>

/*
 * startTrackerWithAccountID:arguments withDict:options
 * Discussion:
 * Starts tracking using Google Analytics
 */
- (void) startTrackerWithAccountID:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

/*
 * trackEvent:arguments withDict:options
 * Discussion:
 * Tracks event and sends data to Google Analytics
 */
- (void) trackEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

/*
 * trackPageview:arguments withDict:options
 * Discussion:
 * Tracks screen views and sends data to Google Analytics
 */
- (void) trackPageview:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
@end
