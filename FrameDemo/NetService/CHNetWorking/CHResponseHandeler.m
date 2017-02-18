//
//  CHResponseHandeler.m
//  OC_Tools
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "CHResponseHandeler.h"
#import "AppConfig.h"

@implementation CHResponseHandeler

+ (void)handelResponse:(NSDictionary *)response
                 error:(NSError *)error
          originalData:(BOOL)originalData
               success:(CHRequestSuccessBlock)successBlock
               failure:(CHRequestFailBlock)failureBlock {
    if (error) {
        if (failureBlock) {
            failureBlock(kDefaultErrorDescription);
        }
        return;
    }
    
    NSDictionary *data = [response allValues].firstObject;
    if (![data isKindOfClass:[NSDictionary class]]) {
        failureBlock(kDefaultErrorDescription);
        return;
    }
    
    BOOL isSuccess = [data[@"Success"] boolValue];
    int errorCode = [data[@"ErrCode"] intValue];
    NSString *msg = data[@"Message"];
    
    if (!isSuccess) {
        
        if (failureBlock) {
            failureBlock(msg ? msg : kDefaultErrorDescription);
        }
        if (errorCode == 202) {//踢下线操作
            //ShowErrorHUD(msg);
//            [[CHAppContext sharedContext] clear];
        }
    } else {
        if (successBlock) {
            if (originalData) {
                successBlock(data);
            } else {
                id object = data[@"Data"] ? data[@"Data"] : data[@"Datas"];
                if ([object isEqual:[NSNull null]]) {
                    object = nil;
                }
                
                successBlock(object);
            }
        }
    }
}

+ (void)handelResponse:(NSDictionary *)response
                 error:(NSError *)error
               success:(CHRequestSuccessBlock)successBlock
               failure:(CHRequestFailBlock)failureBlock {
    [self handelResponse:response error:error originalData:YES success:successBlock failure:failureBlock];
}

@end
