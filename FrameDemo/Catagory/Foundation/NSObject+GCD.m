//
//  NSObject+GCD.m
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "NSObject+GCD.h"

@implementation NSObject (GCD)

- (void)dispatch_afterDelay:(NSTimeInterval)time block:(void (^)())block{
    if ([NSThread isMainThread]) {
        NSParameterAssert(block);
        block();
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSParameterAssert(block);
                block();
            });
        });
    }
}

@end
