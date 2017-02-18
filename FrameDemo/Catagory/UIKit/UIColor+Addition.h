//
//  UIColor+Addition.h
//  OC_Tools
//
//  Created by Apple on 16/7/13.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR(__X__) [UIColor hexStringToColor:__X__]

@interface UIColor (Addition)

/*
 * 十六进制颜色值转换成UIColor对象
 */
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

- (UIImage*)createImageWithColor;

@end
