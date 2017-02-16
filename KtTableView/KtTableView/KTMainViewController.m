//
//  ViewController.m
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KTMainViewController.h"
#import "KtMainTableViewCell.h"
#import "KtMainTableViewDataSource.h"

#import "AFNetworking.h"
#import "KtTableViewBaseItem.h"
#import "KtMainTableModel.h"

#import "MJRefresh.h"

@implementation KTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createModel];
}

- (void)createModel {
    self.listModel = [[KtMainTableModel alloc] initWithAddress:@"/mooclist.php"];
    self.listModel.delegate = self;
}

- (void)createDataSource {
    self.dataSource = [[KtMainTableViewDataSource alloc] init]; // 这一步创建了数据源
}

- (void)requestDidSuccess {
    for (KtMainTableBookItem *book in ((KtMainTableModel *)self.listModel).tableViewItem.books) {
        KtTableViewBaseItem *item = [[KtTableViewBaseItem alloc] init];
        item.itemTitle = book.bookTitle;
        [self.dataSource appendItem:item];
    }
}

@end
