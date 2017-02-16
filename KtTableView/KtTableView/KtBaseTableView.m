//
//  KtBaseTableView.m
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseTableView.h"
#import "KtBaseTableViewCell.h"
#import "KtTableViewSectionObject.h"
#import "KtTableViewBaseItem.h"
#import "MJRefresh.h"

@implementation KtBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;
        self.delegate = self;
        self.isNeedPullDownToRefreshAction = NO;
        self.isNeedPullUpToRefreshAction = NO;
    }
    return self;
}

- (void)setKtDataSource:(id<KtTableViewDataSource>)ktDataSource {
    if (_ktDataSource != ktDataSource) {
        _ktDataSource = ktDataSource;
        self.dataSource = ktDataSource;
    }
}

#pragma mark - 上拉加载和下拉刷新
- (void)setIsNeedPullDownToRefreshAction:(BOOL)isEnable {
    if (_isNeedPullDownToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullDownToRefreshAction = isEnable;
    __block typeof(self) weakSelf = self;
    if (_isNeedPullDownToRefreshAction) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if ([weakSelf.ktDelegate respondsToSelector:@selector(pullDownToRefreshAction)]) {
                [weakSelf.ktDelegate pullDownToRefreshAction];
            }
        }];
        
    }
}

- (void)setIsNeedPullUpToRefreshAction:(BOOL)isEnable
{
    if (_isNeedPullUpToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullUpToRefreshAction = isEnable;
    __block typeof(self) weakSelf = self;
    if (_isNeedPullUpToRefreshAction) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if ([weakSelf.ktDelegate respondsToSelector:@selector(pullUpToRefreshAction)]) {
                [weakSelf.ktDelegate pullUpToRefreshAction];
            }
        }];
    }
}

- (void)stopRefreshingAnimation {
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)triggerRefreshing {
    [self.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    id<KtTableViewDataSource> dataSource = (id<KtTableViewDataSource>)tableView.dataSource;
    
    KtTableViewBaseItem *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];

    if (object.cellHeight == CellInvalidHeight) { // 没有高度缓存
        object.cellHeight = [cls tableView:tableView rowHeightForObject:object];
    }
    return object.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ktDelegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]) {
        id<KtTableViewDataSource> dataSource = (id<KtTableViewDataSource>)tableView.dataSource;
        id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        [self.ktDelegate didSelectObject:object atIndexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if ([self.ktDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.ktDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.ktDelegate respondsToSelector:@selector(headerViewForSectionObject:atSection:)]) {
        id<KtTableViewDataSource> dataSource = (id<KtTableViewDataSource>)tableView.dataSource;
        KtTableViewSectionObject *sectionObject = [((KtTableViewDataSource *)dataSource).sections objectAtIndex:section];
        
        return [self.ktDelegate headerViewForSectionObject:sectionObject atSection:section];
    }
    else if ([self.ktDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.ktDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

#pragma mark - 传递原生协议

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ktDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.ktDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
@end
