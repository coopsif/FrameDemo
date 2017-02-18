//
//  UtilsMacro.h
//  FrameDemo
//
//  Created by apple on 17/1/12.
//  Copyright © 2017年 Master. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

//引入相关类
#import "CHRequestManager.h"
#import "CHlistRequest.h"
#import <YYKit/YYKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

//引入相关宏
#import "HelperHeader.h"
#import "CatagoryHeader.h"
#import "NotificationMacro.h"
#import "VendorMacro.h"

//屏幕
#define  KK_SW [[UIScreen mainScreen] bounds].size.width
#define  KK_SH [[UIScreen mainScreen] bounds].size.height
#define  FIVE_FIT(s) ((s*Screen_W)/320.0)
#define  SIX_FIT(s) ((s*Screen_W)/375.0)

//颜色
#define K_Random_Rgb [UIColor colorWithRed:arc4random()%11*0.1 green:arc4random()%11*0.1 blue:arc4random()%11*0.1 alpha:1]
#define K_Com_Rgb(s) [UIColor colorWithRed:s/255.0 green:s/255.0 blue:s/255.0 alpha:1]
#define K_Rgb(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//读取(本地)图片
#define ImageOfFile(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
#define ImageNameOfFile(A)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
#define ImageOfName(A)        [UIImage imageNamed:A];


//DUG输出
#ifdef DEBUG
# define DLog(format, ...)     NSLog(format,##__VA_ARGS__);
# define DMoreLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

//String
#define ISEMPTY(_v) (_v == nil || _v.length == 0)
#define FORMAT(string, args...) [NSString stringWithFormat:string, args]
#define StringFromFloat(__FLOAT__)     FORMAT(@"%.2f", __FLOAT__)
#define STR_FROM_INT(__X__) [NSString stringWithFormat:@"%ld", __X__]
#define STR_FROM_DOUBLE(__X__) [NSString stringWithFormat:@"%f", __X__]


/**
 Synthsize a weak or strong reference.
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 self.xxx
 ...
 }];
 */

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif


#endif /* UtilsMacro_h */
