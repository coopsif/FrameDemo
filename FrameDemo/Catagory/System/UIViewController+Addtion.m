//
//  UIViewController+Addtion.m
//  FrameDemo
//
//  Created by apple on 17/1/13.
//  Copyright © 2017年 Master. All rights reserved.
//

#import "UIViewController+Addtion.h"
#import <objc/runtime.h>
@implementation UIViewController (Addtion)

static char delayKey;

- (void)navigaitonBarBottomShowMessage:(NSString *)messages{
    UINavigationController *navi = self.navigationController;
    BOOL isHidden = navi.navigationBar.hidden;
    
    if (!navi || isHidden) {
        return;
    }
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    // 2.显示文字
    label.text = messages;
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithRed:254/255.0  green:129/255.0 blue:0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    CGRect rect = CGRectMake(0, CGRectGetMaxY([self.navigationController navigationBar].frame) - 35, self.view.frame.size.width, 35);
    label.frame = rect;
    // 5.添加到导航控制器的view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 6.动画
    CGFloat duration = 0.55;
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:20
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // 往下移动一个label的高度
                         label.transform = CGAffineTransformMakeTranslation(0, label.frame.size.height);
                     } completion:^(BOOL finished) {
                         // 延迟delay秒后，再执行动画
                         NSNumber *delayNub = objc_getAssociatedObject(self, &delayKey);
                         NSTimeInterval delay = delayNub?[delayNub doubleValue]:1;
                         [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:0.8 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                             // 恢复到原来的位置
                             label.transform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             [label removeFromSuperview];
                         }];
                     }];
    
}

- (void)navigaitonBarBottomShowMessage:(NSString *)message delayHidden:(NSTimeInterval)delay{
    objc_setAssociatedObject(self, &delayKey, @(delay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self navigaitonBarBottomShowMessage:message];
}

@end
