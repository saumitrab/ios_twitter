//
//  ComposeViewController.m
//  twitter
//
//  Created by Saumitra Bhanage on 8/18/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Compose tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIBarButtonItem *postTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStyleBordered target:self action:@selector(postTweet)];
    
    self.navigationItem.rightBarButtonItem = postTweetButton;
    
    [self.composeTweetText becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postTweet {
    NSString *tweetText = [NSString stringWithString:[self.composeTweetText text]];
    
    [[TwitterClient instance] postTweetWithStatus:tweetText success:^(AFHTTPRequestOperation *operation, id response) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"The Tweet was posted successfully." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Failed to post The Tweet." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
    }];
}

@end
