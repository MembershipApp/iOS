//
//  ProgressController.m
//  AdaptiveMobile
//
//  Created by AdaptiveMobile Security Ltd.
//  Copyright 2012 AdaptiveMobile Security Ltd. All rights reserved.
//

#import "ProgressController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ProgressController

@synthesize progressString;

-(void) dealloc
{	
	[progressScreen release];
	[progressString release];
	[super dealloc];
}

-(void)startProgressBar
{
	[[UIApplication sharedApplication]beginIgnoringInteractionEvents];

//	if(progressScreen == nil)
//		progressScreen = [self getProgressScreen];
	progressScreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
	progressScreen.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.9];
	progressScreen.layer.cornerRadius = 8;
	progressScreen.layer.borderColor = [[UIColor blackColor]CGColor];
	progressScreen.layer.borderWidth = 3.0;
	progressScreen.center = [UIApplication sharedApplication].keyWindow.center;
	
	UILabel* progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 70, progressScreen.frame.size.width-10, 80)];
	progressLabel.numberOfLines = 0;
	progressLabel.text = progressString;
	progressLabel.backgroundColor = [UIColor clearColor];
	progressLabel.textColor = [UIColor whiteColor];
	progressLabel.textAlignment = UITextAlignmentCenter;
	[progressScreen addSubview:progressLabel];
	[progressLabel release];
	
	UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((progressScreen.frame.size.width - 37)/2, 30, 37, 37)];
	activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	[activityView startAnimating];
	activityView.opaque = YES;
	[progressScreen addSubview:activityView];
	[activityView release];
	
	[[UIApplication sharedApplication].keyWindow addSubview:progressScreen];
}	

-(void) removeProgressBar
{
	[[UIApplication sharedApplication]endIgnoringInteractionEvents];
	[progressScreen removeFromSuperview];
}

@end
