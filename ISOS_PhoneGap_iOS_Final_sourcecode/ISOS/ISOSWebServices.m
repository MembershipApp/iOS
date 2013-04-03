//
//  ISOSWebServices.m
//  ISOS
//
//  Created by Harshil Patel on 31/10/12.
//
//

#import "ISOSWebServices.h"
#import "ASIHTTP/ASIHTTPRequest.h"
#import "JSONClasses/JSON.h"
#import "AppDelegate.h"

#define LOGIN_URL @"http://appzhao.com:9910/authenticate"
//#define LOGIN_URL @"http://202.131.96.148/isos/services/authenticate/"
#define CHECKIN_URL @"http://appzhao.com:9910/checkin"

//#define CHECKIN_URL @"http://202.131.96.148/isos/services/checkin/"

//#define LOGIN_URL @"http://202.131.96.148/isostesting/Services/authenticate/"
//#define CHECKIN_URL @"http://202.131.96.148/isostesting/Services/checkin/"

@implementation ISOSWebServices
@synthesize responseDict,callBackId,bgTaskId;

-(void)webServiceCall:(NSMutableArray*)_arguments withDict:(NSMutableDictionary*)options{
    
    self.responseDict = [NSDictionary dictionaryWithDictionary:options];
    self.callBackId = [_arguments objectAtIndex:0];
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if ([[options objectForKey:@"method"] isEqualToString:@"login"]) {

        NSString *serviceurlstr = [NSString stringWithFormat:@"%@",LOGIN_URL];
        NSURL *requesturl = [NSURL URLWithString:[serviceurlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
        [jsonDict setObject:[options objectForKey:@"membershipID"] forKey:@"UserName"];
        [jsonDict setObject:[options objectForKey:@"DeviceToken"] forKey:@"DeviceToken"];
        [jsonDict setObject:@"i" forKey:@"DeviceType"];
        [jsonDict setObject:@"123" forKey:@"Password"];
        [jsonDict setObject:@"login" forKey:@"Method"];
    
        [appDel.progressController startProgressBar];
        
        [self sendASIRequest:jsonDict requestURL:requesturl];
        
    }
    else if ([[options objectForKey:@"method"] isEqualToString:@"checkin"]){
        
        NSString *serviceurlstr = [NSString stringWithFormat:@"%@",CHECKIN_URL];

        NSURL *requesturl = [NSURL URLWithString:[serviceurlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
        [jsonDict setObject:[options objectForKey:@"UserName"] forKey:@"UserName"];
        [jsonDict setObject:[options objectForKey:@"DeviceToken"] forKey:@"DeviceToken"];
        [jsonDict setObject:[options objectForKey:@"Latitude"] forKey:@"Latitude"];
        [jsonDict setObject:[options objectForKey:@"Longitude"] forKey:@"Longitude"];
        [jsonDict setObject:@"checkin" forKey:@"Method"];
        
        
        NSDate *currentDate = [NSDate date];
        
        NSString *str = [NSString stringWithFormat:@"%lf",[currentDate timeIntervalSince1970]];
        [jsonDict setObject:str forKey:@"timestamp"];
        
        [appDel.progressController startProgressBar];
        [self sendASIRequest:jsonDict requestURL:requesturl];
    }    
}

- (void)sendASIRequest:(NSMutableDictionary*)_dictionary requestURL:(NSURL*)url{
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSString *jsonStr = [_dictionary JSONRepresentation];
    D_Log(@"JSON Str: %@",jsonStr);
    D_Log(@"URL: %@",url);
    
    int ttl = [jsonStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *reqData = [NSMutableData dataWithBytes:[jsonStr UTF8String] length:ttl];
    [request setPostBody:reqData];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"application/json;charset=UTF-8;"];
    [request setDelegate:self];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    //  Successful response
    NSString *responseString = [request responseString];
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDel.progressController removeProgressBar];
    
    SBJsonParser *parser = [[SBJsonParser new]autorelease];
    NSDictionary *responseDictionary = [parser objectWithString:responseString];
    
    //  Status code - 0 for successful authentication
    //  Status code - 4 for successful checkin

    CDVPluginResult *result=nil;
    if ([request responseStatusCode]==200) {
        if ([[responseDictionary objectForKey:@"StatusCode"]integerValue]==0) {
            if ([[self.responseDict objectForKey:@"method"] isEqualToString:@"checkin"]) {
                
            }
             result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:self.responseDict];
            [self writeJavascript:[result toSuccessCallbackString:self.callBackId]];
        }
        else if([[responseDictionary objectForKey:@"StatusCode"]integerValue]==1){
            result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:self.responseDict];
            [self writeJavascript:[result toErrorCallbackString:self.callBackId]];
        }
    }
    
    else{
        
        if ([UIApplication sharedApplication].applicationState==UIApplicationStateActive) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDel.progressController removeProgressBar];
    
    if ([UIApplication sharedApplication].applicationState==UIApplicationStateActive) {
        UIAlertView *failureAlert = [[UIAlertView alloc]initWithTitle:@"Server Error" message:@"Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [failureAlert show];
        [failureAlert release];
    }
}

- (void)dealloc{
    [responseDict release];
    [callBackId release];
    [super dealloc];
}
@end
