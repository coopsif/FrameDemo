//
//  ThemeManager.h
//  Chuangdou
//
//  Created by Cher on 16/2/23.
//  Copyright © 2016年 com.saiku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeManager : NSObject
/**
 *  主题管家
 *
 *  @return 主题管家单例
 */
+ (instancetype)defaultManager;

/**
 *  设置app内所有Label的字体
 *
 *  @param size 字体大小
 *
 *  @return UIFont 对象
 */
- (UIFont *)fontOfapp:(CGFloat)size;

/**
 *  画线条
 *
 *  @return app内线条
 */
- (UILabel *)drawLine;

@end
