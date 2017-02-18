//
//  CHRequestManager.m
//  OC_Tools
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "CHRequestManager.h"
#import "CHResponseHandeler.h"
#import "AppConfig.h"

#define REQUEST_TIMEOUT 30 //请求超时时间

@interface CHRequestManager()

@property (nonatomic, strong) AFHTTPSessionManager *aFHTTPSessionManager;
@property (nonatomic, strong) NSMutableDictionary *dataTaskdict;
@property (nonatomic, strong) NSNumber *recordedRequestId;

@end

@implementation CHRequestManager

+ (instancetype)share{
    
    static CHRequestManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[CHRequestManager alloc] init];
    });
    return _manager;
}

- (id)init{
    self = [super init];
    if (self) {
        _aFHTTPSessionManager = [AFHTTPSessionManager manager];
        [self initializationRequestSerializer];
    }
    return self;
}

- (NSNumber *)generateRequestId
{
    if (_recordedRequestId == nil) {
        _recordedRequestId = @(1);
    } else {
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @(1);
        } else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}

- (NSMutableDictionary *)dataTaskdict{
    
    if (_dataTaskdict == nil) {
        _dataTaskdict = [NSMutableDictionary dictionary];
    }
    return _dataTaskdict;
}


#pragma mark ---- public method
- (void)initializationRequestSerializer{
    
    AFHTTPRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setTimeoutInterval:REQUEST_TIMEOUT];
    _aFHTTPSessionManager.requestSerializer = serializer;
    _aFHTTPSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //_aFHTTPSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
}

- (void)updateRequestSerializer:(NSDictionary *)parameters{
    
    if (!parameters) return;
    AFHTTPRequestSerializer *serializer = _aFHTTPSessionManager.requestSerializer;
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [serializer setValue:obj forHTTPHeaderField:key];
    }];
    _aFHTTPSessionManager.requestSerializer = serializer;
}

- (NSNumber *)requestHUDWithUrl:(NSString *)url
                        type:(RequestType)type
                  parameters:(NSDictionary *)parameters
                     success:(CHRequestSuccessBlock)success
                     failure:(CHRequestFailureBlock)failure{
    ShowLoading;
    return [self requestUrl:url type:type parameters:parameters success:^(id responseObject) {
        success(responseObject);
        HideHUD;
    } failure:^(NSString *errorDescription) {
        failure(errorDescription);
        ShowErrorHUD(errorDescription);
    }];
}

- (NSNumber *)requestWithUrl:(NSString *)url
                                  type:(RequestType)type
                            parameters:(NSDictionary *)parameters
                               success:(CHRequestSuccessBlock)success
                            failure:(CHRequestFailureBlock)failure{
    return [self requestUrl:url type:type parameters:parameters success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSString *errorDescription) {
        failure(errorDescription);
    }];
}


- (void)cancelRequestWithRequestID:(NSNumber *)requestID{
    
    if (requestID == nil) return;
    NSURLSessionDataTask *task = self.dataTaskdict[requestID];
    [task cancel];
    [self.dataTaskdict removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList{
    
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}


#pragma mark ----- private method
- (void)removeCompletedRequest:(NSNumber *)requestID{
    
    NSURLSessionDataTask *task = self.dataTaskdict[requestID];
    [task cancel];
    [self.dataTaskdict removeObjectForKey:requestID];
}


- (NSNumber *)requestUrl:(NSString *)url
                    type:(RequestType)type
              parameters:(NSDictionary *)parameters
                 success:(CHRequestSuccessBlock)success
                 failure:(CHRequestFailureBlock)failure{
    
    if (!url) return nil;
    NSURLSessionDataTask *dataTask;
    NSNumber *requestId = [self generateRequestId];
    NSString *allUrl = FORMAT(@"%@/%@", kServiceHost, url);
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [requestParams addEntriesFromDictionary:[self publicParams]];
    DLog(@"==allUrl%@===%@",url,requestParams);
    
    switch (type) {
        case Net_GET:
        {
            dataTask = [_aFHTTPSessionManager GET:allUrl parameters:requestParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSURLSessionDataTask *storedTask = self.dataTaskdict[requestId];
                if (storedTask == nil) {
                    success?success(nil):nil;
                    return;// 如果这个operation是被cancel的，那就不用处理回调了。
                }
                
                [self.dataTaskdict removeObjectForKey:requestId];
                NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                
                [CHResponseHandeler handelResponse:responseDic error:nil success:success failure:failure];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(kDefaultErrorDescription);
                }
                NSURLSessionDataTask *storedTask = self.dataTaskdict[requestId];
                if (storedTask == nil) return;
                [self.dataTaskdict removeObjectForKey:requestId];
            }];
        }
            break;
        case Net_POST:
        {
            
            dataTask = [_aFHTTPSessionManager POST:allUrl parameters:requestParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSURLSessionDataTask *storedTask = self.dataTaskdict[requestId];
                if (storedTask == nil) {
                    success?success(nil):nil;
                    return;
                }
                [self.dataTaskdict removeObjectForKey:requestId];
                NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                [CHResponseHandeler handelResponse:responseDic error:nil success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"====%@",error);
                if (failure) {
                    failure(kDefaultErrorDescription);
                }
                NSURLSessionDataTask *storedTask = self.dataTaskdict[requestId];
                if (storedTask == nil) return;
                [self.dataTaskdict removeObjectForKey:requestId];
            }];
        }
            break;
        case Net_DELETE:
        {
            dataTask = [_aFHTTPSessionManager DELETE:allUrl parameters:requestParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                NSURLSessionDataTask *storedTask = self.dataTaskdict[requestId];
                if (storedTask == nil) {
                    success?success(nil):nil;
                    return;
                }
                [self.dataTaskdict removeObjectForKey:requestId];
                NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                [CHResponseHandeler handelResponse:responseDic error:nil success:success failure:failure];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(kDefaultErrorDescription);
                }
                NSURLSessionDataTask *storedTask = self.dataTaskdict[requestId];
                if (storedTask == nil) return;
                [self.dataTaskdict removeObjectForKey:requestId];
            }];
        }
            break;
        case Net_PUT:
        {
            dataTask = [_aFHTTPSessionManager PUT:allUrl parameters:requestParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                NSURLSessionDataTask *storedTask = self.dataTaskdict[requestId];
                if (storedTask == nil) {
                    success?success(nil):nil;
                    return;
                }
                [self.dataTaskdict removeObjectForKey:requestId];
                NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                [CHResponseHandeler handelResponse:responseDic error:nil success:success failure:failure];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(kDefaultErrorDescription);
                }
                NSURLSessionDataTask *storedTask = self.dataTaskdict[requestId];
                if (storedTask == nil) return;
                [self.dataTaskdict removeObjectForKey:requestId];
            }];
        }
            break;
        default:
            break;
    }
    self.dataTaskdict[requestId] = dataTask;
    return requestId;
}


- (void)uploadImgUrl:(NSString *)url parameters:(NSDictionary *)parameters loading:(NSString *)loading withImg:(NSArray *)imageArr withKeys:(NSArray *)keys success:(CHRequestSuccessBlock)success
           failure:(CHRequestFailureBlock)failure{
    
    NSString *allUrl = FORMAT(@"%@/%@", kServiceImgUploadHost, url);
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [requestParams addEntriesFromDictionary:[self publicParams]];
    DLog(@"==allUrl==%@===%@",allUrl,requestParams);
    if (!ISEMPTY(loading)) {
        ShowLoadingHUD(loading);
    }
    [_aFHTTPSessionManager POST:allUrl parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (imageArr.count) {
            for (int i =0; i<imageArr.count; i++) {
                UIImage *image = imageArr[i];
                NSString *key = keys[i];
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                //上传图片，以文件流的格式
                [formData appendPartWithFileData:imageData name:key fileName:fileName mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HideHUD;
        NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [CHResponseHandeler handelResponse:responseDic error:nil success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@",error);
        HideHUD;
        [CHResponseHandeler handelResponse:nil error:nil success:success failure:failure];
    }];
}


//设置公共参数
- (NSDictionary *)publicParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *seid = nil;
    if (!ISEMPTY(seid)) {
        [params setValue:seid forKey:@"sessionId"];
    }
    return params;
}

@end
