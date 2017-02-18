//
//  CHlistRequest.h
//  OC_Tools
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CHlistRequestDelegate;

@interface CHlistRequest : NSObject

@property (nonatomic, strong) NSMutableArray *listData;//接口全部数据(翻页)
@property (nonatomic, strong) NSMutableArray *requestList;//接口请求数据

@property (nonatomic, assign, readonly) BOOL isReceiveAllList;
@property (nonatomic, assign, readonly) NSDate *lastUpdateDate;
@property (nonatomic, assign) BOOL isUseLastID;       //翻页时，根据lastID请求。而不是根据page请求。默认为NO。

@property (nonatomic, strong) NSDictionary *originData;//原始数据

@property (nonatomic, copy) NSString *currentPageKey;//当前页数

@property (nonatomic, assign) id<CHlistRequestDelegate> delegate;

@property (nonatomic, assign) int pageLength;//数据长度 默认20

/**
 *  发起网络请求(带加载HUD)
 *
 *  @param entityClass     实体类
 *  @param actionUrl       请求地址
 *  @param listKey         数组数据在字典中的key
 *
 *  @return CHlistRequest 对象
 */
- (id)initWithEntityClass:(Class)entityClass actionUrl:(NSString *)actionUrl;
- (id)initWithEntityClass:(Class)entityClass actionUrl:(NSString *)actionUrl listKey:(NSString *)key;

//请求第一页数据 param 请求参数
- (void)requestFirstList:(NSDictionary *)param;
//下一页
- (void)requestNextList:(NSDictionary *)param;

@end


@protocol CHlistRequestDelegate<NSObject>

- (void)listRequestDidFinish:(CHlistRequest *)viewModel;

@end
