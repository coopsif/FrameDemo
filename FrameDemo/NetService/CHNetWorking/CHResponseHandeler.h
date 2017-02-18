//
//  CHResponseHandeler.h
//  OC_Tools
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CHRequestSuccessBlock)(id responseObject);
typedef void(^CHRequestFailBlock)(NSString *errorDescription);

static NSString * const kDefaultErrorDescription = @"网络连接失败";

@interface CHResponseHandeler : NSObject


+ (void)handelResponse:(NSDictionary *)response
                 error:(NSError *)error
               success:(CHRequestSuccessBlock)successBlock
               failure:(CHRequestFailBlock)failureBlock;


+ (void)handelResponse:(NSDictionary *)response
                 error:(NSError *)error
          originalData:(BOOL)originalData
               success:(CHRequestSuccessBlock)successBlock
               failure:(CHRequestFailBlock)failureBlock;

@end
