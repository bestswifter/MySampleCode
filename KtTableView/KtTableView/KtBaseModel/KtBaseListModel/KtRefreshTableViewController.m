//
//  KtRefreshTableViewController.m
//  KtTableView
//
//  Created by baidu on 16/5/20.
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
    
}

- (void)refreshRequestDidSuccess {
    [self.dataSource clearAllItems];
}

- (void)handleAfterRequestFinish {
    [self.tableView stopRefreshingAnimation];
    [self.tableView reloadData];
}

- (void)didLoadLastPage {
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma -mark 
- (void)pullUpToRefreshAction {
    [self.listModel loadNextPage];
}

- (void)pullDownToRefreshAction {
    [self.listModel refresh];
}

@end
