//
//  UIViewController+Addtion.h
//  FrameDemo
//
//  Created by apple on 17/1/13.
//  Copyright © 2017年 Master. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Addtion)

- (void)navigaitonBarBottomShowMessage:(NSString *)message;
- (void)navigaitonBarBottomShowMessage:(NSString *)message delayHidden:(NSTimeInterval)delay;

@end
