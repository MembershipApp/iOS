//
//  GoogleAnalyticsPlugin.m
//  ISOS
//
//  Created by shishir on 22/10/12.
//
//

#import "GoogleAnalyticsPlugin.h"

@implementation GoogleAnalyticsPlugin

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;

- (void) startTrackerWithAccountID:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString* accountId = [arguments objectAtIndex:1];
	[[GANTracker sharedTracker] startTrackerWithAccountID:accountId
										   dispatchPeriod:kGANDispatchPeriodSec
												 delegate:self];
     
    
}
- (void) trackEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString* category = [options valueForKey:@"category"];
	NSString* action = [options valueForKey:@"action"];
	NSString* label = [options valueForKey:@"label"];
	int value = [[options valueForKey:@"value"] intValue];
	NSError *error;
	if (![[GANTracker sharedTracker] trackEvent:category
										 action:action
										  label:label
										  value:value
									  withError:&error]) {
		// Handle error here
	}
}
- (void) trackPageview:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString* pageUri = [arguments objectAtIndex:1];
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:pageUri withError:&error]) {
	}
}

#pragma mark- Google Analytics Delegate Methods
// Invoked when a hit has been dispatched.
- (void)hitDispatched:(NSString *)hitString
{
}

// Invoked when a dispatch completes. Reports the number of hits
// dispatched and the number of hits that failed to dispatch. Failed
// hits will be retried on next dispatch.
- (void)trackerDispatchDidComplete:(GANTracker *)tracker
                  eventsDispatched:(NSUInteger)hitsDispatched
              eventsFailedDispatch:(NSUInteger)hitsFailedDispatch{
}
@end
