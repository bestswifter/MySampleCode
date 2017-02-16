//
//  KtBaseModel.m
//  KtTableView
//
//  Created by bestswifter on 16/5/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseModel.h"

@implementation KtBaseModel

- (instancetype)initWithAddress:(NSString *)address {
    self = [super init];
    if (self) {
        _address = address;
        _serverApi = [[KtBaseServerAPI alloc] initWithServer:@"http://1.footballapp.sinaapp.com"];  // 这个URL应该是配置文件中的常量
    }
    return self;
}

- (BOOL)isLoading { // 如果将来支持长链接，这里的逻辑会变复杂
    return self.serverApi.state == KT_PROC_STAT_CREATED || self.serverApi.state == KT_PROC_STAT_LOADING;
}

// 子类重载处理数据的逻辑
- (void)handleParsedData:(KtBaseItem *)parsedData {
    
}

#pragma -mark 短链接
- (void)loadWithShortConnection {
    assert(self.address != nil && self.params != nil);
    if ([self isLoading]) {
        return;
    }
    [self loadInnerWithShortConnection];
}

- (void)loadInnerWithShortConnection {
    __block KtBaseModel *wself = self;
    NSString *requestAddRess = self.address;
    
    [self.serverApi accessAPI:requestAddRess WithParams:self.params completionBlock:^(KtBaseServerAPI *api) {
        KtBaseModel *sself = wself;
        [sself handleShortConnectionBlock:api];
    }];
}

- (void)handleShortConnectionBlock:(KtBaseServerAPI *)api {
    if (api.state == KT_PROC_STAT_SUCCEED && !api.error) {
        [self parseData:api.jsonData]; // 解析 JSON 数据
    }
    else if((api.state == KT_PROC_STAT_FAILED || api.error) && api.state !=  KT_PROC_STAT_CANCELLED) {
        // 做一些错误弹窗处理
        if (self.completionBlock) {
            self.completionBlock(self);
        }
    }
    //取消或其他
    else {
        // 做一些弹窗处理
        if ( self.completionBlock) {
            self.completionBlock(self);
        }
    }
}

#pragma -mark 长链接
- (void)loadWithLongConnection {
    assert(self.address != nil && self.params != nil);
    if ([self isLoading]) {
        return;
    }
    [self loadInnerWithShortConnection];
}

- (void)loadInnerWithLongConnection {
    return;
}

# pragma -mark 刷新与取消
- (void)cancel {
    [self.serverApi cancel];
}

- (void)refresh {
    [self.serverApi refresh];
}

#pragma -mark 字典转对象
- (void)parseData:(NSDictionary *)data {
    __block NSDictionary* dataCopy = [[NSDictionary alloc] initWithDictionary:data];
    __block KtBaseModel* wself = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //异步解析数据
        KtBaseModel *sself = wself;
        __block KtBaseItem* item = [[sself.parseDataClassType alloc] initWithData:dataCopy] ;
        
        //同步通知到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [sself handleParsedData:item];
            if ( sself.completionBlock) {
                sself.completionBlock(wself);
            }
        });
    });
}

@end
