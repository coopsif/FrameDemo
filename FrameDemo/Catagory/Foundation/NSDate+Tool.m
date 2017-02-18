//
//  NSDate+Tool.m
//  wangwanglife
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 kajiter. All rights reserved.
//

#import "NSDate+Tool.h"

@implementation NSDate (Tool)

- (NSString *)currentMonthName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:usLocale];
    [formatter setDateFormat:@"M"];
    return [formatter stringFromDate:self];
}

- (NSString *)currentYearName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:self];
}


@end
