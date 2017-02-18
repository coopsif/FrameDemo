//
//  AlipayHelper.h
//  Chuangdou
//
//  Created by Cher on 16/3/9.
//  Copyright © 2016年 com.saiku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ResultBlock) (BOOL);

static NSString  *alipay_ID = @"id";
static NSString  *alipay_Amount = @"amount";
static NSString  *alipay_BackUrl = @"backUrl";

//支付宝支付助手
@interface AlipayHelper : NSObject

/**
 *  支付宝支付调用 参数 keys: alipay_ID alipay_Amount alipay_BackUrl
 *
 *  @param parameters parameters 参数（必填） -- keys: alipay_ID alipay_Amount alipay_BackUrl 对应的value: 订单ID 支付金额 支付回调地址
 *  @param block      支付结果回调
 */
+ (void)alipay:(NSDictionary *)parameters result:(ResultBlock)block;

+ (void)alipayStr:(NSString *)payStr result:(ResultBlock)block;

@end
