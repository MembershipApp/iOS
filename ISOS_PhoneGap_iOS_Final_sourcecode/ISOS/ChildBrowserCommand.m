//  Created by Jesse MacFadyen on 10-05-29.
//  Copyright 2010 Nitobi. All rights reserved.
//  Copyright 2012, Randy McMillan
// Continued maintainance @RandyMcMillan 2010/2011/2012

#import "ChildBrowserCommand.h"

#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PhoneGapViewController.h>
#endif
//#else
#ifdef CORDOVA_FRAMEWORK
#import <Cordova/CDVViewController.h>
#endif


@implementation ChildBrowserCommand

@synthesize childBrowser;

- (void) showWebPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{
    NSLog(@"URL: %@",[arguments objectAtIndex:0]);
	if(childBrowser == NULL)
	{
		childBrowser = [[ ChildBrowserViewController alloc ] initWithScale:FALSE ];
		childBrowser.delegate = self;
	}
	
#ifdef PHONEGAP_FRAMEWORK
	PhoneGapViewController* cont = (PhoneGapViewController*)[ super appViewController ];
	childBrowser.supportedOrientations = cont.supportedOrientations;
	[ cont presentModalViewController:childBrowser animated:YES ];
#endif
    
#ifdef CORDOVA_FRAMEWORK
    CDVViewController* cont = (CDVViewController*)[ super viewController ];
	//childBrowser.supportedOrientations = cont.supportedOrientations;
	[ cont presentModalViewController:childBrowser animated:YES ];
#endif
    
	NSString *url = (NSString*) [arguments objectAtIndex:1];
	[childBrowser loadURL:url  ];

}

-(void) close:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{
	[ childBrowser closeBrowser];
	
}

-(void) onClose
{
//	NSString* jsCallback = [NSString stringWithFormat:@"ChildBrowser._onClose();",@""];
//	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
}

-(void) onOpenInSafari
{
	NSString* jsCallback = [NSString stringWithFormat:@"ChildBrowser._onOpenExternal();",@""];
	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
}


-(void) onChildLocationChange:(NSString*)newLoc
{
	
	NSString* tempLoc = [NSString stringWithFormat:@"%@",newLoc];
	NSString* encUrl = [tempLoc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	 
	NSString* jsCallback = [NSString stringWithFormat:@"ChildBrowser._onLocationChange('%@');",encUrl];
	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];

}




@end