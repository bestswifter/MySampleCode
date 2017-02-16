//
//  KtRefreshTableViewController.m
//  KtTableView
//
//  Created by bestswifter on 16/5/20.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtRefreshTableViewController.h"
#import "MJRefresh.h"

@implementation KtRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.isNeedPullUpToRefreshAction = YES;
    self.tableView.isNeedPullDownToRefreshAction = YES;
}

#pragma -mark KtBaseListModelProtocol
- (void)loadRequestDidSuccess {
    [self requestDidSuccess];
}

- (void)refreshRequestDidSuccess {
    [self.dataSource clearAllItems];
    [self requestDidSuccess];
}

- (void)handleAfterRequestFinish {
    [self.tableView stopRefreshingAnimation];
    [self.tableView reloadData];
}

- (void)didLoadLastPage {
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma -mark KtTableViewDelegate
- (void)pullUpToRefreshAction {
    [self.listModel loadNextPage];
}

- (void)pullDownToRefreshAction {
    [self.listModel refresh];
}

@end
