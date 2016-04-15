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

@interface KTMainViewController () <UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) KtMainTableViewDataSource *dataSource;

@end

@implementation KTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray arrayWithObjects:@"第一条消息", @"第二条消息", @"第三条消息", @"第四条消息", @"第五条消息", nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    
    self.dataSource = [[KtMainTableViewDataSource alloc] init]; // 这一步创建了数据源
    self.tableView.dataSource = self.dataSource;  // 绑定了数据源
    self.tableView.tableFooterView = [[UIView alloc] init]; // 去掉多余分割线
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
