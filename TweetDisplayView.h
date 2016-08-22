


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface TwitterDisplayView : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *displayTweetWebView;

@property (weak,nonatomic) NSURL *imageURL;
@end