//
//  KtBaseTableView.h
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KtTableViewDataSource.h"

@class KtTableViewSectionObject;
@protocol KtTableViewDelegate<UITableViewDelegate>

@optional

/**
 * 选择一个cell的回调，并返回被选择cell的数据结构和indexPath
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

- (UIView *)headerViewForSectionObject:(KtTableViewSectionObject *)sectionObject atSection:(NSInteger)section;

// 下拉刷新触发的方法

- (void)pullDownToRefreshAction;

// 上拉加载触发的方法
 
- (void)pullUpToRefreshAction;

// 将来可以有 cell 的编辑，交换，左滑等回调

// 这个协议继承了UITableViewDelegate ，所以自己做一层中转，VC 依然需要实现某些代理方法。

@end

@interface KtBaseTableView : UITableView<UITableViewDelegate>

@property (nonatomic, assign) id<KtTableViewDataSource> ktDataSource;

@property (nonatomic, assign) id<KtTableViewDelegate> ktDelegate;

// 是否需要下拉刷新和上拉加载
@property (nonatomic, assign) BOOL isNeedPullDownToRefreshAction;
@property (nonatomic, assign) BOOL isNeedPullUpToRefreshAction;

- (void)stopRefreshingAnimation;
- (void)triggerRefreshing;

@end
