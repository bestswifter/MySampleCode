//
//  KtTableViewController.m
//  KtTableView
//
//  Created by baidu on 16/4/16.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtTableViewController.h"
#import "KtTableViewDataSource.h"

@implementation KtTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        [self createDataSource];
    }
    return self;
}

// 这个方法实际上要被子类重写，生成对应类型的 data source
- (void)createDataSource {
    self.dataSource = [[KtTableViewDataSource alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)createTableView {
    if (!self.tableView) {
        self.tableView = [[KtBaseTableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        self.tableView.ktDelegate = self;
        self.tableView.ktDataSource = self.dataSource;
        [self.view addSubview:self.tableView];
    }
}

@end
