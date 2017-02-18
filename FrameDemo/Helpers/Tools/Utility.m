//
//  BaseFunc.m
//  Pocket91
//
//  Created by Liu Jinyong on 14-6-28.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "Utility.h"
#import "CCHUDWindow.h"
@implementation Utility

+ (BOOL)checkInput:(id)object tip:(NSString *)tip {
    BOOL result = YES;
    
    if ([object respondsToSelector:@selector(text)]) {
        NSString *text = [object text];
        if (text.length == 0) {
            result = NO;
            ShowWarningHUD(tip);
        }
    }else if ([object isKindOfClass:[NSString class]]) {
        NSString *text = object;
        if (text.length == 0) {
            result = NO;
            ShowWarningHUD(tip);
        }        
    }else if ([object isKindOfClass:[UIButton class]]) {
        UIButton *btn = object;
        NSString *text = btn.titleLabel.text;
        if (text.length == 0) {
            result = NO;
            ShowWarningHUD(tip);
        }
    }else {
        if (object == nil) {
            result = NO;
            ShowWarningHUD(tip);
        }
    }
    return result;
}

@end
