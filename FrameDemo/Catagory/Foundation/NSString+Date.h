//
//  NSString+Date.h
//  wangwanglife
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 kajiter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

- (NSString *)dateToTomorrow;

- (NSString *)dateToToday;

- (NSString *)dateToYesterday;

+ (NSString *)currentTime;//返回当前时间 格式为 20161019

@end
