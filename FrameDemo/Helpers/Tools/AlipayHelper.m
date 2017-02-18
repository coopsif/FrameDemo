//
//  AlipayHelper.m
//  Chuangdou
//
//  Created by Cher on 16/3/9.
//  Copyright © 2016年 com.saiku. All rights reserved.
//

#import "AlipayHelper.h"
//支付宝支付头文件
/*
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
*/
#import "AppConfig.h"// ALIPAY_partner ALIPAY_seller ALIPAY_privateKey 宏定义

@implementation AlipayHelper

/*
+ (void)alipay:(NSDictionary *)parameters result:(ResultBlock)block{
     
     NSString *partner         = ALIPAY_partner;
     NSString *seller          = ALIPAY_seller;
     NSString *privateKey      = ALIPAY_privateKey;
     //partner和seller获取失败,提示
     if ([partner length] == 0 ||
         [seller length] == 0 ||
         [privateKey length] == 0)
     {
          UIAlertView *alert   = [[UIAlertView alloc] initWithTitle:@"提示"
                                                          message:@"缺少partner或者seller或者私钥。"
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
          [alert show];
          return;
     }
     if (!parameters.count) {
          UIAlertView *alert   = [[UIAlertView alloc] initWithTitle:@"提示"
                                                          message:@"缺少支付参数。"
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
          [alert show];
          return;
     }
     NSString *alipayID        = [parameters valueForKey:alipay_ID];
     NSString *alipayAmount    = [parameters valueForKey:alipay_Amount];
     NSString *alipayBackUrl   = [parameters valueForKey:alipay_BackUrl];
     //将商品信息赋予AlixPayOrder的成员变量
     Order *order              = [[Order alloc] init];
     order.partner             = partner;
     order.sellerID              = seller;
     order.outTradeNO             = alipayID; //订单ID（由商家自行制定）
     //order.productName       = product.subject; //商品标题
     order.subject         = [NSString stringWithFormat:@"%u",arc4random()%10]; //商品标题
     //order.productDescription = product.body; //商品描述
     order.totalFee              = alipayAmount; //商品价格
     order.notifyURL           = alipayBackUrl; //支付宝回调URL
     order.service             = @"mobile.securitypay.pay";
     order.paymentType         = @"1";
     order.inputCharset        = @"utf-8";
     order.itBPay              = @"30m";
     order.showURL             = @"m.alipay.com";
     
     //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
     NSString *appScheme       = @"alisdkdemo";
     //将商品信息拼接成字符串
     NSString *orderSpec       = [order description];
     NSLog(@"orderSpec = %@",orderSpec);
     //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
     id<DataSigner> signer     = CreateRSADataSigner(privateKey);
     NSString *signedString    = [signer signString:orderSpec];
     //将签名成功字符串格式化为订单字符串,请严格按照该格式
     NSString *orderString     = nil;
     if (signedString != nil) {
          orderString          = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                         orderSpec, signedString, @"RSA"];
          [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
               NSNumber *code  = resultDic[@"resultStatus"];
               BOOL result     = NO;
               if ([code integerValue] == 6001) result    = NO;
               if ([code integerValue] == 9000) result    = YES;
               if (block) block(result);
          }];
     }
     
}
*/
+ (void)alipayStr:(NSString *)payStr result:(ResultBlock)block{
    NSString *appScheme       = @"";
    /*
    [[AlipaySDK defaultService] payOrder:payStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSNumber *code  = resultDic[@"resultStatus"];
        BOOL result     = NO;
        if ([code integerValue] == 6001) result    = NO;
        if ([code integerValue] == 9000) result    = YES;
        if (block) block(result);
    }];
     */
}

@end
