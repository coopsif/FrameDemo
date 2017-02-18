//
//  NSString+Date.m
//  wangwanglife
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 kajiter. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

static NSDateFormatter *formatter = nil;

- (NSString *)dateToTomorrow;
{
    //NSString *dateString = @"2014-09-01";
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *date = [formatter dateFromString:self];
    NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
    NSString * tomorrowStr = [formatter stringFromDate:tomorrow];
    return tomorrowStr;
}

- (NSString *)dateToYesterday{
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *date = [formatter dateFromString:self];
    NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:date];
    NSString * yesterdayStr = [formatter stringFromDate:yesterday];
    return yesterdayStr;
}

- (NSString *)dateToToday{
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *date = [formatter dateFromString:self];
    NSString * todayStr = [formatter stringFromDate:date];
    return todayStr;
}

+ (NSString *)currentTime{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    return [NSString stringWithFormat:@"%ld%ld%ld",(long)year,(long)month,(long)day];
}

@end
