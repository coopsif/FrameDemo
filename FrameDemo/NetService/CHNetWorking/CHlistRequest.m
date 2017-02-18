//
//  CHlistRequest.m
//  OC_Tools
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "CHlistRequest.h"
#import "AppConfig.h"
#define FIRST_PAGE 0
#define DEFAULT_PAGE_LENGTH 20

// Request Key
NSString * const kCurrentPageKey    =   @"pageIndex";
NSString * const kPageLengthKey     =   @"pageSize";

// Local Key
NSString * const kDefaultListNode   =   @"list";

@interface CHlistRequest()
{
    Class _entityClass;
    NSString *_listKey;
    NSString *_requestAction;
    int _currentPage;
    BOOL _isFirstLoad;
}

@property (nonatomic, assign, readonly) int totalCount;
@property (nonatomic, assign, readonly) BOOL isReloadList;
@property (nonatomic, copy) NSString *listKey;

@property (nonatomic, strong)NSNumber *requestId;//当前请求id

@end

@implementation CHlistRequest

- (void)dealloc{
    [[CHRequestManager share] cancelRequestWithRequestID:self.requestId];//取消当前请求
}


- (id)initWithEntityClass:(Class)entityClass actionUrl:(NSString *)actionUrl {
    return [self initWithEntityClass:entityClass actionUrl:actionUrl listKey:kDefaultListNode];
}

- (id)initWithEntityClass:(Class)entityClass actionUrl:(NSString *)actionUrl listKey:(NSString *)key {
    if (self = [super init]) {
        self.currentPageKey = kCurrentPageKey;
        _entityClass = entityClass;
        _requestAction = actionUrl;
        _pageLength = DEFAULT_PAGE_LENGTH;
        _currentPage = FIRST_PAGE;
        _listData = [[NSMutableArray alloc] init];
        _requestList = [[NSMutableArray alloc] init];
        _isReceiveAllList = YES;
        _isFirstLoad = YES;
        _isUseLastID = NO;
        self.listKey = key;
    }
    return self;
}

#pragma mark - Public methods

- (void)requestFirstList:(NSDictionary *)param {
    _isReloadList = YES;
    [self startRequest:param page:FIRST_PAGE pageSize:_pageLength];
}

- (void)requestNextList:(NSDictionary *)param {
    _isReloadList = NO;
    [self startRequest:param page:_currentPage+1 pageSize:_pageLength];
}

#pragma mark - Private methods

- (void)startRequest:(NSDictionary *)param page:(int)page pageSize:(int)pageSize {
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithDictionary:param];
    
    [requestInfo setObject:@(page) forKey:_currentPageKey];
    [requestInfo setObject:@(pageSize) forKey:kPageLengthKey];
    DLog(@"参数==%@",requestInfo);
    @weakify(self)
   self.requestId = [[CHRequestManager share] requestHUDWithUrl:_requestAction
                                                        type:Net_GET
                                                  parameters:requestInfo
                                                     success:^(id responseObject) {
                                                         @strongify(self)
                                                         DLog(@"%@",responseObject);
                                                         self.originData = responseObject;
                                                         [self pretreatData];
                                                         id data = responseObject[@"Datas"] ? : responseObject[@"Data"];
                                                         [self buildListDataWithResult:data];
                                                         if ([self.delegate respondsToSelector:@selector(listRequestDidFinish:)]) {
                                                             [self.delegate listRequestDidFinish:self];
                                                         }
                                                     } failure:^(NSString *errorDescription) {
                                                         @strongify(self)
                                                         
                                                         if ([self.delegate respondsToSelector:@selector(listRequestDidFinish:)]) {
                                                             [self.delegate listRequestDidFinish:self];
                                                         }
                                                     }];
}

- (void)pretreatData {
    if (_isReloadList) {
        [_listData removeAllObjects];
        _currentPage = FIRST_PAGE;
    }else {
        _currentPage++;
    }
}

- (void)buildListDataWithResult:(id)result {
    NSArray *arr = nil;
    if ([result isKindOfClass:[NSArray class]]) {
        arr = result;
    }else if ([result isKindOfClass:[NSDictionary class]]) {
        arr = [result objectForKey:_listKey];
    }
    
    if ([arr isKindOfClass:[NSArray class]]) {
        [_requestList removeAllObjects];
        if (_entityClass) {
            for (NSDictionary *infoDic in arr) {
                id info = [_entityClass modelWithDictionary:infoDic];
                NSAssert(info, @"[ListRequest]:yy_modelWithDictionary 解析失败");
                [_requestList addObject:info];
            }
        }else {
            [_requestList addObjectsFromArray:arr];
        }
        [_listData addObjectsFromArray:_requestList];
    }
    _isReceiveAllList = _requestList.count < _pageLength;
}


@end
