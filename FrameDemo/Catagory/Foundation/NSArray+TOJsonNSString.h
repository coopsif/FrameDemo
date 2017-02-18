//
//  NSArray+TOJsonNSString.h
//  wangwanglife
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 kajiter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (TOJsonNSString)

- (NSString *)toJSONorNSString;

- (NSString *)toReadJSONorNSString;

- (NSData *)toJSONData;

@end
