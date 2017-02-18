//
//  UITextField+Addtion.m
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "UITextField+Addtion.h"

@implementation UITextField (Addtion)

/** 通过这个属性名，就可以修改textField内部的占位文字颜色 */
static NSString * const LXPlaceholderColorKeyPath = @"placeholderLabel.textColor";

/**
 *  设置占位文字颜色
 */
- (void)setLx_placeholderColor:(UIColor *)lx_placeholderColor
{
    // 这3行代码的作用：1> 保证创建出placeholderLabel，2> 保留曾经设置过的占位文字
    NSString *placeholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeholder;
    
    // 处理xmg_placeholderColor为nil的情况：如果是nil，恢复成默认的占位文字颜色
    if (lx_placeholderColor == nil) {
        lx_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:lx_placeholderColor forKeyPath:LXPlaceholderColorKeyPath];
}

/**
 *  获得占位文字颜色
 */
- (UIColor *)lx_placeholderColor
{
    return [self valueForKeyPath:LXPlaceholderColorKeyPath];
}

@end
