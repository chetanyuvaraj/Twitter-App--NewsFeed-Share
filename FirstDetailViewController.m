

#import <Foundation/Foundation.h>
#import "FirstDetailViewController.h"

@interface FirstDetailViewController ()


@end

@implementation FirstDetailViewController {
    NSString *address;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.eventLabel.text = self.eName;
    self.startLabel.text = self.eST;
    self.stopLabel.text = self.eStop;
    self.locationLabel.text = self.eLocation;
    address = self.eLocation;
    
    [_eventLabel sizeToFit];
    [_locationLabel sizeToFit];
    
    self.title = self.eName;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         MKCoordinateSpan span = MKCoordinateSpanMake(1.25, 1.25);
                         MKCoordinateRegion region = MKCoordinateRegionMake(placemark.coordinate, span);
                         region.center = [(CLCircularRegion *)placemark.region center];
                         region.span.longitudeDelta /= 100.0;
                         region.span.latitudeDelta /= 100.0;
                         
                         [self.mapView setRegion:region animated:YES];
                         [self.mapView addAnnotation:placemark];
                         
                         
                         
                     }
                 }
     ];
    
    _mapView.showsUserLocation = YES;
}
/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* ShopAnnotationIdentifier = @"shopAnnotationIdentifier";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ShopAnnotationIdentifier];
    if (!pinView) {
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ShopAnnotationIdentifier] autorelease];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.animatesDrop = YES;
    }
    return pinView;
}
*/

- (IBAction)pushToTweet:(id)sender {
    
    ACAccountStore *twitter = [[ACAccountStore alloc] init];
    
    // Create an account type
    ACAccountType *twAccountType = [twitter accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    // Request Access to the twitter account
    [twitter requestAccessToAccountsWithType:twAccountType options:nil completion:^(BOOL granted, NSError *error)
     {
         
         if (granted)
         {
             // Create an Account
             ACAccount *twAccount = [[ACAccount alloc] initWithAccountType:twAccountType];
             NSArray *accounts = [twitter accountsWithAccountType:twAccountType];
             
             if ([accounts count] > 0)
             {
                 twAccount = [accounts lastObject];
                 
                 // Version 1.1 of the Twitter API only supports JSON responses.
                 // Create an NSURL instance variable that points to the home_timeline end point.
                 NSURL *twitterURL = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
                 
                 /*
                  Version 1.0 of the Twiter API supports XML responses.
                  Use this URL if you want to see an XML response.
                  NSURL *twitterURL2 = [[NSURL alloc] initWithString:@"http://api.twitter.com/1/statuses/home_timeline.xml"];
                  */
                 
                 //             // Create a request
                 //             SLRequest *requestUsersTweets = [SLRequest requestForServiceType:SLServiceTypeTwitter
                 //                                                                requestMethod:SLRequestMethodPOST
                 //                                                                          URL:twitterURL
                 //                                                                   parameters:nil];
                 //
                 //             // Set the account to be used with the request
                 //             [requestUsersTweets setAccount:twAccount];
                 
                 
                 //             if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
                 //             {
                 //                 SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                 //                 NSString *Id = @"AndrewId:ckovvuri ";
                 //                 self.checkinString = [Id stringByAppendingString:_currentTime1.text];
                 //                 self.checkinString = [_checkinString stringByAppendingString:@" "];
                 //                 self.checkinString = [_checkinString stringByAppendingString:_devicemodel.text];
                 //                 NSLog(@ "%@",self.checkinString);
                 //                 [tweetSheet setInitialText: self.checkinString];
                 //
                 //                 [self presentViewController:tweetSheet animated:YES completion:nil];
                 //
                 //             }
                 NSString *Id = @"AndrewId:ckovvuri ";
                 self.checkinString =[@"@MobileApp4 " stringByAppendingString:Id];
                 self.checkinString = [_checkinString stringByAppendingString:_eName];
                 self.checkinString = [_checkinString stringByAppendingString:@" "];
                 self.checkinString = [_checkinString stringByAppendingString:_eST];
                 self.checkinString = [_checkinString stringByAppendingString:@" "];
                 self.checkinString = [_checkinString stringByAppendingString:_eStop];
                 self.checkinString = [_checkinString stringByAppendingString:@" "];
                 self.checkinString = [_checkinString stringByAppendingString:_eLocation];
                 NSRange stringRange = {0, MIN([_checkinString length], 138)};o
                 stringRange = [_checkinString rangeOfComposedCharacterSequencesForRange:stringRange];
                 NSString *shortString = [_checkinString substringWithRange:stringRange];
                 
                 NSLog(@ "%@",self.checkinString);
                 NSDictionary *message = @{@"status": shortString};
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodPOST
                                           URL:twitterURL parameters:message];
                 
                 postRequest.account = twAccount;
                 
                 [postRequest
                  performRequestWithHandler:^(NSData *responseData,
                                              NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      NSLog(@"Twitter HTTP response: %i",
                            [urlResponse statusCode]);
                      if([urlResponse statusCode] ==200)
                      {
                          UIAlertView *alertView = [[UIAlertView alloc]
                                                    initWithTitle:@"Sucess"
                                                    message:@"Your Tweet has been sucessfully posted"
                                                    delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                          [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                      }
                      else if ([urlResponse statusCode] ==400)
                      {
                          UIAlertView *alertView = [[UIAlertView alloc]
                                                    initWithTitle:@"Bad Request"
                                                    message:@"requests without authentication"
                                                    delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                          [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                      }
                      else if ([urlResponse statusCode] ==401)
                      {
                          UIAlertView *alertView = [[UIAlertView alloc]
                                                    initWithTitle:@"UnAuthorized"
                                                    message:@"Invalid or expired token"
                                                    delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                          [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                      }
                      else if ([urlResponse statusCode] ==403)
                      {
                          UIAlertView *alertView = [[UIAlertView alloc]
                                                    initWithTitle:@"Forbidden"
                                                    message:@"Invalidate, credentials do not allow access to resource"
                                                    delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                          [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                      }
                      else if ([urlResponse statusCode] ==404)
                      {
                          UIAlertView *alertView = [[UIAlertView alloc]
                                                    initWithTitle:@"Not Found"
                                                    message:@"Not Found"
                                                    delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                          [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                      }
                      else if ([urlResponse statusCode] ==500)
                      {
                          UIAlertView *alertView = [[UIAlertView alloc]
                                                    initWithTitle:@"Server Error"
                                                    message:@"Server Unable to connect"
                                                    delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                          [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                      }
                  }];
                 
             }
             
             else
             {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@"Sorry"
                                           message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                           delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                 [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
             }
             
         }
         // If permission is not granted to use the Twitter account...
         
         else
             
         {
             UIAlertView *alertView = [[UIAlertView alloc]
                                       initWithTitle:@"Sorry"
                                       message:@"Permission Not Granted, make sure your device has an internet connection and you have given twitter access"
                                       delegate:self
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
             [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
             NSLog(@"Permission Not Granted");
             NSLog(@"Error: %@", error);
         }
     }];
    
    
}


- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    
    static NSString *reuseId = @"pin";
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        pinView.enabled = YES;
        pinView.canShowCallout = YES;
        pinView.tintColor = [UIColor orangeColor];
    }
    
    else {
        pinView.annotation = annotation;
    }
    
    return pinView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

