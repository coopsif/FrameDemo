//
//  ThemeManager.m
//  Chuangdou
//
//  Created by Cher on 16/2/23.
//  Copyright © 2016年 com.saiku. All rights reserved.
//

#import "UtilsMacro.h"

static ThemeManager *manager = nil;

@implementation ThemeManager

+ (instancetype)defaultManager{
     
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          manager = [[ThemeManager alloc] init];
     });
     return manager;
}

- (UIFont *)fontOfapp:(CGFloat)size{
     
     //UIFont *f = [UIFont fontWithName:@"Helvetica Light" size:size];
     UIFont *f = [UIFont systemFontOfSize:size];
     return f;
}

- (UILabel *)drawLine{
     
     UILabel *label = [UILabel new];
     label.backgroundColor = K_Com_Rgb(153);
     label.alpha = 0.2;
     return label;
}

@end
