//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Saumitra Bhanage on 8/18/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweet.h"

@interface TweetDetailsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *screenname;
@property (nonatomic, weak) IBOutlet UILabel *tweetText;
@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;


@property (nonatomic) Tweet *tweet;

@end
