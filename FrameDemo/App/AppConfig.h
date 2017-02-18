//
//  AppConfig.h
//  FrameDemo
//
//  Created by apple on 17/1/12.
//  Copyright © 2017年 Master. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

//Macro
#import "UtilsMacro.h"


//测试 正式地址切换
//static NSString * const kServiceHost           = @"";    //测试环境
//static NSString * const kServiceImgUploadHost           = @"";    //测试环境

static NSString * const kServiceHost           = @"";       //正式环境
static NSString * const kServiceImgUploadHost           = @"";       //正式环境

// Color
static NSUInteger kThemeColor               = 0xfc4243;//fc4243 0xFEA80D

//Placeholder Img
static NSString * const kPlaceholderList           = @"";
static NSString * const kPlaceholderBanner         = @"";
static NSString * const kPlace165holderBanner      = @"";
static NSString * const kGoodPlaceholderBanner     = @"";
static NSString * const kPlaceholderAvatar         = @"";


#endif /* AppConfig_h */
