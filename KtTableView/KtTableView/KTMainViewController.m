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

#import "AFNetworking.h"
#import "KtTableViewBaseItem.h"

@interface KTMainViewController ()


@end

static NSString * const BaseURLString = @"http://1.footballapp.sinaapp.com/mooclist.php";

@implementation KTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *parameters = @{@"nextPage": @"0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSURLSessionDataTask *task = [manager GET:BaseURLString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *array = dic[@"data"];
        for (NSDictionary *dict in array) {
            KtTableViewBaseItem *item = [[KtTableViewBaseItem alloc] initWithImage:nil Title:dict[@"title"] SubTitle:nil AccessoryImage:nil];
            [self.dataSource appendItem:item];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createDataSource {
    self.dataSource = [[KtMainTableViewDataSource alloc] init]; // 这一步创建了数据源
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
