//
//  UIView+Addition.h
//  HuanYin
//
//  Created by Suteki on 11/16/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

+ (UIView *)blurViewWithStyle:(UIBlurEffectStyle)style;

- (void)addTopSeperatorWithColor:(UIColor *)color;
- (void)addBottomSeperatorWithColor:(UIColor *)color;

- (void)addTapCallBack:(id)target sel:(SEL)selector;
- (void)removeAllSubviews;

@property (nonatomic, assign) IBInspectable BOOL isCircle;
@property (nonatomic, assign) IBInspectable BOOL hasBorder;
@property (nonatomic, assign) IBInspectable BOOL hasSeparator;

@end
