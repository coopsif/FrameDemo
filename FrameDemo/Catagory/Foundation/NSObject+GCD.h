//
//  NSObject+GCD.h
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCD)

//主线程延迟操作
- (void)dispatch_afterDelay:(NSTimeInterval)time block:(void (^)())block;

@end
