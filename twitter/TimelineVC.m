//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "TweetDetailsViewController.h"

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;

- (void)onSignOutButton;
- (void)reload;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *composeTweetButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(composeTweet)];
    
    self.navigationItem.rightBarButtonItem = composeTweetButton;
    
    UINib *tweetsNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:tweetsNib forCellReuseIdentifier:@"TweetCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //TweetCell *cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    Tweet *tweet = self.tweets[indexPath.row];
    
    cell.tweetText.frame = CGRectMake(cell.tweetText.frame.origin.x, cell.tweetText.frame.origin.y, cell.tweetText.frame.size.width, 0);
    
    cell.tweetText.text = tweet.text;
    cell.tweetTime.text = tweet.created_at;
    cell.tweetUsername.text = tweet.username;
    cell.tweetProfileImage.image = tweet.profileImage;
    
    /*
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGSize expectedLabelSize = [tweet.text sizeWithFont:cell.tweetText.font constrainedToSize:maximumLabelSize lineBreakMode:cell.tweetText.lineBreakMode];
    
    //adjust the label the the new height.
    CGRect newFrame = cell.tweetText.frame;
    newFrame.size.height = expectedLabelSize.height;
    cell.tweetText.frame = newFrame;
    */
    
    cell.tweetText.numberOfLines = 0;
    [cell.tweetText sizeToFit];
    
    /*
    cell.tweetText.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [cell.tweetText addGestureRecognizer:tapGesture];
    */
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = self.tweets[indexPath.row];
    return [tweet.text length];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailsViewController *tweetDetailsViewController = [[TweetDetailsViewController alloc] init];
    tweetDetailsViewController.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:tweetDetailsViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

#pragma mark view controller funcitons

- (void)composeTweet {
    ComposeViewController *composeViewController = [[ComposeViewController alloc] init];
    [self.navigationController pushViewController:composeViewController animated:YES];
}

@end
