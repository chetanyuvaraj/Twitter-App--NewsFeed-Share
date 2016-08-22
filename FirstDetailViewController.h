
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocationManager.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface FirstDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *stopLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locManager;
@property (strong, nonatomic) NSString *eName;
@property (strong, nonatomic) NSString *eST;
@property (strong, nonatomic) NSString *eStop;
@property (strong, nonatomic) NSString *eLocation;
@property (strong, nonatomic) NSString *checkinString;

@end

