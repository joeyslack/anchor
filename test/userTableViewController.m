//
//  userTableViewController.m
//  test
//
//  Created by Joe Slack on 1/13/14.
//  Copyright (c) 2014 Joe Slack. All rights reserved.
//

#import "userTableViewController.h"
#import "userTableViewCell.h"
#import "chatViewController.h"

#import "STTwitter.h"

@interface userTableViewController ()

@end

@implementation userTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize content = _content;

-(NSArray *)content
{
    if (!_content) {
        STTwitterAPI *twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"gFP0lgq5weSdb8m7XZoEhA" consumerSecret:@"RBmOf5l17yO2ayEZ3G7KJgPMqNyNbra90udmkSEBog" oauthToken:@"382480441-C2wz0T7kIcKKgW5bi4wLf9vqSRMYkWj2odsCvZUq" oauthTokenSecret:@"KAES1Hdv7TGFPmHa50LCeB0rHm6yoYs4UrD52jeQWb0wR"];
        
        NSLog(@"%@", @"OK GOOD");
        [twitter getHomeTimelineSinceID:nil count:20 successBlock:^(NSArray *statuses) {
            _content = statuses;
            NSLog(@"%@", @"OK GOOD");
            [self.tableView reloadData];
        } errorBlock:^(NSError *error) {
            // ...
            NSLog(@"HERE%@", error);
        }];
    }
    return _content;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return self.content.count;
    return self.content.count;
}

- (userTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"userTableCell";
    userTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    long row = indexPath.row;
    NSDictionary *contentRow;
    
    contentRow = [_content objectAtIndex:row];
	//NSLog(@"Statuses: %@", [tweet objectForKey:@"text"]);
    //NSLog(@"TWEET %@", contentRow);
    //id data = array[@"all_items"][0][@"name"];
    cell.detail.text = [contentRow objectForKey:@"text"];
    cell.title.text = [[contentRow objectForKey:@"user"] objectForKey:@"name"];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[contentRow objectForKey:@"user"] objectForKey:@"profile_image_url"]]];
    cell.image.image = [UIImage imageWithData: imageData];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showUserDetails"])
    {
        chatViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        //int row = [myIndexPath row];
        //detailViewController.carDetailModel = @[_carMakes[row],_carModels[row], _carImages[row]];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

/*- (void) viewDidLayoutSubviews {
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        
    } else {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
        self.navigationController.navigationBar.translucent = NO;
    }
}*/

@end
