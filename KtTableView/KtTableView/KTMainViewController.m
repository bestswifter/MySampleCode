//
//  ViewController.m
//  KtTableView
//
//  Created by baidu on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KTMainViewController.h"
#import "KtMainTableViewCell.h"
#import "KtMainTableViewDataSource.h"

@interface KTMainViewController () <KtTableViewDelegate>

@property (strong, nonatomic) KtMainTableViewDataSource *dataSource;

@end

@implementation KTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[KtBaseTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.ktDelegate = self;
    
    self.dataSource = [[KtMainTableViewDataSource alloc] init]; // 这一步创建了数据源
    self.tableView.ktDataSource = self.dataSource;  // 绑定了数据源
    self.tableView.tableFooterView = [[UIView alloc] init]; // 去掉多余分割线
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
