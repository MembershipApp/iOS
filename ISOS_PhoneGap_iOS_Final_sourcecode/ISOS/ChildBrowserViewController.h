#import <UIKit/UIKit.h>

@protocol ChildBrowserDelegate<NSObject>



/*
 *  onChildLocationChanging:newLoc
 *  
 *  Discussion:
 *    Invoked when a new page has loaded
 */
-(void) onChildLocationChange:(NSString*)newLoc;
-(void) onClose;
@end


@interface ChildBrowserViewController : UIViewController < UIWebViewDelegate > {
	IBOutlet UIWebView* webView;
	IBOutlet UIBarButtonItem* closeBtn;
	IBOutlet UIBarButtonItem* refreshBtn;
	IBOutlet UIBarButtonItem* backBtn;
	IBOutlet UIBarButtonItem* fwdBtn;
	IBOutlet UIActivityIndicatorView* spinner;
	BOOL scaleEnabled;
	BOOL isImage;
	NSString* imageURL;
	NSArray* supportedOrientations;
	id <ChildBrowserDelegate> delegate;
}

@property (nonatomic, retain)id <ChildBrowserDelegate> delegate;
@property (nonatomic, retain) 	NSArray* supportedOrientations;
@property(retain) NSString* imageURL;
@property(assign) BOOL isImage;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation; 
- (ChildBrowserViewController*)initWithScale:(BOOL)enabled;

/*
 * onDoneButtonPress:sender
 * Discussion:
 * Invoked when done button is pressed at the bottom bar
 */
- (IBAction)onDoneButtonPress:(id)sender;
- (IBAction)onSafariButtonPress:(id)sender;

/*
 * loadURL:url
 * Discussion:
 * Invoked when a url is loaded
 */
- (void)loadURL:(NSString*)url;

/*
 * closeBrowser
 * Discussion:
 * Invoked when a child browser is closed
 */
-(void)closeBrowser;

@end
