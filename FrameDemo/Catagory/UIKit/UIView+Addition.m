//
//  UIView+Addition.m
//  HuanYin
//
//  Created by Suteki on 11/16/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "UIView+Addition.h"
#import <Masonry/Masonry.h>

@implementation UIView (Addition)

+ (UIView *)blurViewWithStyle:(UIBlurEffectStyle)style {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyle)style];
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    return blurView;
}

- (void)addBottomSeperatorWithColor:(UIColor *)color {
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 0.5)];
    separator.backgroundColor = color;
    separator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:separator];
}

- (void)addTopSeperatorWithColor:(UIColor *)color {
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    separator.backgroundColor = color;
    separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:separator];
}

- (void)addTapCallBack:(id)target sel:(SEL)selector
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}



#pragma mark - IB

- (BOOL)isCircle {
    return (self.layer.cornerRadius == self.frame.size.width / 2);
}

- (void)setIsCircle:(BOOL)isCircle {
    self.layer.cornerRadius = isCircle ? self.frame.size.width / 2 : 0;
}


- (BOOL)hasBorder {
    return self.layer.borderWidth > 0;
}

- (BOOL)hasSeparator {
    return [self viewWithTag:75634] != nil;
}

- (void)setHasSeparator:(BOOL)hasSeparator {
    UIView *separator = [self viewWithTag:75634];
    if (separator == nil) {
        separator = [[UIView alloc] init];
        separator.tag = 75634;
        separator.backgroundColor = [self separatorColor];
        [self addSubview:separator];
        
        [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-0.5);
            make.height.equalTo(@0.5);
        }];
    }
    separator.hidden = !hasSeparator;
}

- (void)setHasBorder:(BOOL)needBorder {
    if (needBorder) {
        self.layer.borderColor = [self separatorColor].CGColor;
        self.layer.borderWidth = 0.5;
    }else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0;
    }
}

- (UIColor *)separatorColor{
    return [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.35];
}

@end
