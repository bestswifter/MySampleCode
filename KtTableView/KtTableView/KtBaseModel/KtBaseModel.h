//
//  KtBaseModel.h
//  KtTableView
//
//  Created by bestswifter on 16/5/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KtBaseServerAPI.h"
#import "KtBaseItem.h"

@class KtBaseModel;

/*!
 @brief 用于KtBaseModel回调的block定义
 */
typedef void(^KtModelBlock)(KtBaseModel *);

@interface KtBaseModel : NSObject

//自动解析的数据类型 可能在不同线程访问  因此设置为 atomic
@property (assign,atomic) Class parseDataClassType;

// 回调函数
@property (nonatomic, copy) KtModelBlock completionBlock;

//网络请求
@property (nonatomic,retain) KtBaseServerAPI *serverApi;

//网络请求参数
@property (nonatomic,retain) NSDictionary *params;

//请求地址 需要在子类init中初始化
@property (nonatomic,copy)   NSString *address;

- (instancetype)initWithAddress:(NSString *)address;
- (void)handleParsedData:(KtBaseItem *)parsedData;

- (void)loadWithShortConnection;
- (void)loadWithLongConnection;
- (void)refresh;
- (void)cancel;

@end
