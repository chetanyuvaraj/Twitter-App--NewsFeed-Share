

#import <Foundation/Foundation.h>
#import "TweetDisplayView.h"

@interface TwitterDisplayView()

@end

@implementation TwitterDisplayView

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:currentURL]]];
//    self.webView.hidden = NO;

    _displayTweetWebView.autoresizesSubviews = YES;
    _displayTweetWebView.frame = self.view.frame;
    _displayTweetWebView.frame = self.view.bounds;
    _displayTweetWebView.scalesPageToFit = true;
    NSURLRequest* request = [NSURLRequest requestWithURL:self->_imageURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    NSLog(@"it is %@",_imageURL);
    [self->_displayTweetWebView loadRequest:request];
    
}
//- (void)loadUIWebView
//{
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];  //Change self.view.bounds to a smaller CGRect if you don't want it to take up the whole screen
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:currentURL]]];
//    [self.view addSubview:webView];
//    [webView release];
//}



@end