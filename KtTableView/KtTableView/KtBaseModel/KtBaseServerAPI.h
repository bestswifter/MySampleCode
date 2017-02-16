//
//  KtBaseServerAPI.h
//  KtTableView
//
//  Created by bestswifter on 16/5/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/*!
 @brief API访问的处理状态，IDPServerAPI.state
 */
typedef enum {
    KT_PROC_STAT_CREATED = 1,
    KT_PROC_STAT_LOADING,
    KT_PROC_STAT_SUCCEED,
    KT_PROC_STAT_FAILED,
    KT_PROC_STAT_CANCELLED
} KtProcessStateEnum;

/*!
 @brief Http请求方法
 @discussion POST方法
 @discussion GET方法ß
 */
typedef enum {
    KT_REQUEST_POST,   // POST方法
    KT_REQUEST_GET,    // GET方法
} KtHttpRequestMethod;

// ServerAPI 的回调
@class KtBaseServerAPI;
typedef void(^KtServerAPICompletionBlock)(KtBaseServerAPI *);

@interface KtBaseServerAPI : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

// request
@property (nonatomic, readonly) NSString *server;   // 形如 www.address.of.api，可兼容前面带“http://”、以及后面带“/”的情况
@property (nonatomic, copy) NSString *api;  // 形如 /some/api/to/access，可兼容前面不带“/”的情况
@property (nonatomic, readonly) NSDictionary *reqParams;    // 请求参数
@property (nonatomic, readonly) NSDictionary *files;    // 请求文件
@property (nonatomic, copy) KtServerAPICompletionBlock userBlock;  // serverapi回调的block

// response
@property (nonatomic, retain) NSError *error; // code为IDPErrorEnum类型，服务器返回存放在userInfo的errno和errmsg里
@property (nonatomic, retain) NSDictionary *jsonData;   // 解析出的JSON
@property (nonatomic, retain) NSData *rawData;          // 原始data，用于二进制结果
@property (nonatomic, readonly, copy) NSString *rawString;    // 原始字符串，用于文本结果，lazyloading
@property (nonatomic, retain) id protobufParserData;    // 服务器返回的protobuf解析后的数据

// state
@property (nonatomic, assign) KtProcessStateEnum state;

// 性能信息
@property (nonatomic, readonly) CFTimeInterval startTime;   // 请求发起时间
@property (nonatomic, readonly) CFTimeInterval netCost;     // 网络耗时

- (id)initWithServer:(NSString *)server;

/*!
 @brief 访问API，子类不需要重载
 @discussion 本方法可重复调用，会自动中止当前请求（但并不调用用户回调）
 @discussion 回调调用时机：请求失败、请求被中止、请求成功
 @discussion 回调一般是根据state访问error或者parsedData，并关掉菊花
 
 @param api    形如 /some/api/to/access，可兼容前面不带“/”的情况
 @param params 参数
 @param files  文件
 @param requestMethod KtHttpRequestMethod(GET/POST)
 @param block  KtServerAPICompletionBlock 回调
 
 */
- (void)accessAPI:(NSString *)api
       WithParams:(NSDictionary *)params
            files:(NSDictionary *)files
    requestMethod:(KtHttpRequestMethod)method
  completionBlock:(KtServerAPICompletionBlock)block;

/*!
 @brief 访问API，子类不需要重载 (DEFAULT POST METHOD)
 
 @param api    形如 /some/api/to/access，可兼容前面不带“/”的情况
 @param params 参数
 @param files  文件
 @param block  KtServerAPICompletionBlock 回调
 
 */
- (void)accessAPI:(NSString *)api
       WithParams:(NSDictionary *)params
            files:(NSDictionary *)files
  completionBlock:(KtServerAPICompletionBlock)block;

/*!
 @brief 访问API, 省略files参数的版本
 
 @param api    形如 /some/api/to/access，可兼容前面不带“/”的情况
 @param params 参数
 @param block  KtServerAPICompletionBlock 回调
 
 */
- (void)accessAPI:(NSString *)api
       WithParams:(NSDictionary *)params
  completionBlock:(KtServerAPICompletionBlock)block;

- (void)cancel;
- (void)refresh;

@end
