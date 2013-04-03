//
//  ISOSWebServices.h
//  ISOS
//
//  Created by Harshil Patel on 31/10/12.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "ProgressController.h"

@interface ISOSWebServices : CDVPlugin{
    NSString *callBackId; // Callback id
    NSDictionary *responseDict; // Server response dictionary
}
@property (nonatomic,retain) NSString *callBackId;
@property (nonatomic,retain) NSDictionary *responseDict;
@property (nonatomic, readwrite) UIBackgroundTaskIdentifier bgTaskId;

/*
 * webServiceCall:_arguments withDict:options
 * Discussion:
 * Phonegap plugin to invoke HTTP web service call
 */
- (void)webServiceCall:(NSMutableArray*)_arguments withDict:(NSMutableDictionary*)options;

/*
 * sendASIRequest:_dict requestURL:url
 * Discussion
 * ASIHTTP Request
 */
- (void)sendASIRequest:(NSMutableDictionary*)_dictionary requestURL:(NSURL*)url;
@end
