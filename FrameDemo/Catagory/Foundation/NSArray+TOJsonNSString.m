//
//  NSArray+TOJsonNSString.m
//  wangwanglife
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 kajiter. All rights reserved.
//

#import "NSArray+TOJsonNSString.h"

@implementation NSArray (TOJsonNSString)

- (NSString *)toJSONorNSString{
    NSData *data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:nil];
    if (data == nil) {
        return nil;
    }
    NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}


- (NSString *)toReadJSONorNSString{
    NSData *data=[NSJSONSerialization dataWithJSONObject:self
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:nil];
    if (data == nil) {
        return nil;
    }
    NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

- (NSData *)toJSONData{
    NSData *data=[NSJSONSerialization dataWithJSONObject:self
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:nil];
    return data;
}

@end
