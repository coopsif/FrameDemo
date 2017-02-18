//
//  CHRequestManager.h
//  OC_Tools
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, RequestType)
{
    Net_GET = 0,
    Net_POST = 1,
    Net_DELETE = 2,
    Net_PUT,
};


typedef void(^CHRequestSuccessBlock)(id responseObject);
typedef void(^CHRequestFailureBlock)(NSString *errorDescription);

@interface CHRequestManager : NSObject

/**
 *  获取CHNetwork单例对象
 *
 *  @return 单例对象
 */
+ (instancetype)share;

/**
 *  初始化(还原)网络请求头
 */
- (void)initializationRequestSerializer;

/**
 *  更新网络请求头
 *
 *  @param parameters 更新网络请求头字典参数
 */
- (void)updateRequestSerializer:(NSDictionary *)parameters;

/**
 *  发起网络请求(带加载HUD)
 *
 *  @param url        请求地址
 *  @param type       请求类型 RequestType
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 标记网络请求id
 */
- (NSNumber *)requestHUDWithUrl:(NSString *)url
                           type:(RequestType)type
                     parameters:(NSDictionary *)parameters
                        success:(CHRequestSuccessBlock)success
                        failure:(CHRequestFailureBlock)failure;

/**
 *  发起网络请求(无加载HUD)
 *
 *  @param url        请求地址
 *  @param type       请求类型 RequestType
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 标记网络请求id
 */
- (NSNumber *)requestWithUrl:(NSString *)url
                               type:(RequestType)type
                         parameters:(NSDictionary *)parameters
                            success:(CHRequestSuccessBlock)success
                            failure:(CHRequestFailureBlock)failure;

//图片上传
- (void)uploadImgUrl:(NSString *)url
        parameters:(NSDictionary *)parameters
           loading:(NSString *)loading
           withImg:(NSArray *)imageArr
          withKeys:(NSArray *)keys
           success:(CHRequestSuccessBlock)success
           failure:(CHRequestFailureBlock)failure;

/**
 *  取消指定标记的网络请求
 *
 *  @param requestID 指定标记id
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

/**
 *  取消指定标记组的网络请求
 *
 *  @param requestIDList 指定标记组
 */
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


@end
