//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)username {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"name"];
}

- (NSString *)screenname {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"screen_name"];
}

- (UIImage *)profileImage {
    NSString *url =[[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"profile_image_url"];
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
}

- (NSString *)created_at {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat: @"EEE MMM dd HH:mm:ss Z yyyy"];
    
    NSDate *created_at_date = [dateFormatter dateFromString:[self.data valueOrNilForKeyPath:@"created_at"]];
    NSDate *now = [NSDate date];
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSSecondCalendarUnit;

    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:created_at_date  toDate:now  options:0];

    //NSLog(@"Conversion: %dmin %dhours %ddays %dmoths",[conversionInfo minute], [conversionInfo hour], [conversionInfo day], [conversionInfo month]);

    if ( [conversionInfo day] > 0 ) {
        return [NSString stringWithFormat:@"%dd", [conversionInfo day]];
    }
    if ( [conversionInfo hour] > 0) {
        return [NSString stringWithFormat:@"%dh", [conversionInfo hour]];
    }
    if ( [conversionInfo minute] > 0) {
        return [NSString stringWithFormat:@"%dm", [conversionInfo minute]];
    }
    if ( [conversionInfo second] > 0) {
        return [NSString stringWithFormat:@"%ds", [conversionInfo second]];
    }
    return @"just now";
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
