//
//  KtBaseListModel.h
//  KtTableView
//
//  Created by bestswifter on 16/5/18.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseModel.h"
#import "KtBaseListItem.h"

@protocol KtBaseListModelProtocol <NSObject>

@required
- (void)refreshRequestDidSuccess;
- (void)loadRequestDidSuccess;
- (void)didLoadLastPage;
- (void)handleAfterRequestFinish; // 请求结束后的操作，刷新tableview或关闭动画等。

@optional
- (void)didLoadFirstPage;

@end

@interface KtBaseListModel : KtBaseModel

@property (nonatomic, strong) KtBaseListItem *listItem;
@property (nonatomic, weak) id<KtBaseListModelProtocol> delegate;
@property (nonatomic, assign) BOOL isRefresh; // 如果为是，表示刷新，否则为加载。

- (void)loadPage:(int)pageNumber;
- (void)loadNextPage;
- (void)loadPreviousPage;

@end
