//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Saumitra Bhanage on 8/18/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetDetailsViewController.h"

@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.username.text = self.tweet.username;
    self.tweetText.text = self.tweet.text;
    self.profileImageView.image = self.tweet.profileImage;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
