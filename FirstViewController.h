

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLCalendar.h"
@class FirstDetailViewController;

@interface FirstViewController : UITableViewController

@property (strong, nonatomic) FirstDetailViewController *detailViewController;
@property (nonatomic, strong) GTLServiceCalendar *service;
@property (nonatomic, strong) UITextView *output;
@property (nonatomic, strong)   NSMutableArray *eStart;
@property (nonatomic, strong)   NSMutableArray *ename;
@property (nonatomic, strong)   NSMutableArray *eStop;
@property (nonatomic, strong)   NSMutableArray *eLocation;
@property (nonatomic, strong)   NSString *subLabel;


@end
