

#import "TwitterViewController.h"
#import "TweetDisplayView.h"

@interface TwitterViewController()

@end

@implementation TwitterViewController

bool flag = false;
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getTimelineTweets];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
//-(UITableView *)makeTableView
//{
//    CGFloat x = 0;
//    CGFloat y = 50;
//    CGFloat width = self.view.frame.size.width;
//    CGFloat height = self.view.frame.size.height - 50;
//    CGRect tableFrame = CGRectMake(x, y, width, height);
//    
//    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
//    
//    tableView.rowHeight = 45;
//    tableView.sectionFooterHeight = 22;
//    tableView.sectionHeaderHeight = 22;
//    tableView.scrollEnabled = YES;
//    tableView.showsVerticalScrollIndicator = YES;
//    tableView.userInteractionEnabled = YES;
//    tableView.bounces = YES;
//    
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    
//    return tableView;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.tableView = [self makeTableView];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"newFriendCell"];
//    [self.view addSubview:self.tableView];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"newFriendCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
//    
//    Friend *friend = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    **//THIS DATA APPEARS**
//    cell.textLabel.text = friend.name;
//    cell.textLabel.font = [cell.textLabel.font fontWithSize:20];
//    cell.imageView.image = [UIImage imageNamed:@"icon57x57"];
//    
//    **//THIS DATA DOES NOT APPEAR**
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i Games", friend.gameCount];
//    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
//    
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"detailsView" sender:self];
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    //I set the segue identifier in the interface builder
//    if ([segue.identifier isEqualToString:@"detailsView"])
//    {
//        
//        NSLog(@"segue"); //check to see if method is called, it is NOT called upon cell touch
//        
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        ///more code to prepare next view controller....
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tweetTableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = _dataSource[[indexPath row]];
    cell.textLabel.numberOfLines = 0;
    
    //-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
    //{
    //    [self performSegueWithIdentifier:@"detailsView" sender:self];
    //}
    //
    //- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    //{
    //    //I set the segue identifier in the interface builder
    //    if ([segue.identifier isEqualToString:@"detailsView"])
    //    {
    //
    //        NSLog(@"segue"); //check to see if method is called, it is NOT called upon cell touch
    //
    //        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    //        ///more code to prepare next view controller....
    //    }
    //}
    NSDictionary *entity = [tweet objectForKey:@"entities"];
    NSArray *media = [entity objectForKey:@"media"];
    NSDictionary *media1 = [media objectAtIndex:0];
    _mediaURL = [media1 objectForKey:@"media_url_https"];
//    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//        static NSString *CellIdentifier = @"newFriendCell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        }
//        //etc.
//        return cell;
//    }
    
    [cell.textLabel setText: tweet[@"text"]];
    
    if (_mediaURL)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *tweet = _dataSource[[indexPath row]];
    
    NSDictionary *entity = [tweet objectForKey:@"entities"];
    NSArray *media = [entity objectForKey:@"media"];
    NSLog(@"%@",media);
    NSDictionary *media1 = [media objectAtIndex:0];
    _mediaURL = [media1 objectForKey:@"media_url_https"];
    NSLog(@"%@", _mediaURL);
    
    if(_mediaURL)
    {
        _imageURL = [[NSURL alloc] initWithString:_mediaURL];
        NSLog(@"%@", _imageURL);
        
        [self performSegueWithIdentifier:@"displayImage" sender:self->_imageURL];
        flag = false;
    }
    
    else {
        [self timelineNoImageExceptionThrow];
    }
    
}

- (void)getTimelineTweets {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        [account requestAccessToAccountsWithType:accountType
                                         options:nil completion:^(BOOL granted, NSError *error)
         {
             if (granted == YES)
             {
                 NSArray *arrayOfAccounts = [account
                                             accountsWithAccountType:accountType];
                 
                 if ([arrayOfAccounts count] > 0)
                 {
                     ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                     
                     NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                     
                     NSMutableDictionary *parameters =
                     [[NSMutableDictionary alloc] init];
                     [parameters setObject:@"50" forKey:@"count"];
                     [parameters setObject:@"1" forKey:@"include_entities"];
                     [parameters setObject:@"0" forKey:@"exclude_replies"];
                     
                     SLRequest *postRequest = [SLRequest
                                               requestForServiceType:SLServiceTypeTwitter
                                               requestMethod:SLRequestMethodGET
                                               URL:requestURL parameters:parameters];
                     
                     postRequest.account = twitterAccount;
                     
                     [postRequest performRequestWithHandler:
                      ^(NSData *responseData, NSHTTPURLResponse
                        *urlResponse, NSError *error)
                      {
                          self.dataSource = [NSJSONSerialization
                                             JSONObjectWithData:responseData
                                             options:NSJSONReadingMutableLeaves
                                             error:&error];
                          
                          if (self.dataSource.count != 0) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [self.tweetTableView reloadData];
                              });
                          }
                      }];
                 }
             } else {
                 NSString *message = @"allow app to use Twitter account";
                 [self twitterExceptionHandling:message];
                 
             }
         }];
    } else {
        NSString *message = @"No Twitter account found";
        [self twitterExceptionHandling:message];
        
    }
    
}

-(void)twitterExceptionHandling:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops!!!" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"User pressed Cancel");
                                   }];
    
    UIAlertAction *settingsAction = [UIAlertAction
                                     actionWithTitle:NSLocalizedString(@"Settings", @"Settings action")
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction *action)
                                     {
                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                         
                                     }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:settingsAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)timelineNoImageExceptionThrow {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Image" message:@"This tweet has no image to display" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK");
                                   }];
    
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    TwitterDisplayView *view = [segue destinationViewController];
    view.imageURL = self->_imageURL;
}


@end
