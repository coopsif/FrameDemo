//
//  NSString+Factory.h
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Factory)

//判断字符是否是纯数字
- (BOOL)isPureNumandCharacters;

//返回文本高度(需要传入文本固定宽度)
- (CGFloat)textHeightWithFontSize:(NSInteger)fontSize FixedWidth:(CGFloat)width;
//返回文本宽度
- (CGFloat)textWidthWithFontSize:(NSInteger)fontSize;
//时间戳  -- 转换成 对应的时间 
- (NSString *)dateStrWith:(NSInteger )formatType;
//
- (NSDate *)dateWithTimeStamp;

- (BOOL)nowTimeDifference:(NSInteger)hour;
//身份证号
- (BOOL)checkIsIdentityCard;
//中划线
- (NSMutableAttributedString *)drawlineOnCenter;
//下划线
- (NSMutableAttributedString *)drawlineOnBottom;
@end
