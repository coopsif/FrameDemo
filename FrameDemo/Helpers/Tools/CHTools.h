//
//  CHTools.h
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHTools : NSObject

/**
 *  返回一个富文本对象
 *
 *  @param sourceText    源文本
 *  @param colorText     需要设置颜色的文本
 *  @param textcolor     设置富文本文本颜色
 *  @param fontSize      设置富文本文本size
 *
 *  @return 返回所求的值
 */

+ (NSMutableAttributedString *)coreText:(NSString *)sourceText colorText:(NSString *)colorText Textcolor:(UIColor *)textcolor fontSize:(NSInteger)fontSize;

//压缩图片
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
