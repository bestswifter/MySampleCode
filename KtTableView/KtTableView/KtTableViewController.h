//
//  KtTableViewController.h
//  KtTableView
//
//  Created by baidu on 16/4/16.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KtBaseTableView.h"

@class KtTableViewDataSource;

@protocol KtTableViewControllerDelegate <NSObject>

@required
- (void)createDataSource;

@end

@interface KtTableViewController : UIViewController<KtTableViewDelegate, KtTableViewControllerDelegate>

@property (nonatomic, strong) KtBaseTableView *tableView;
@property (nonatomic, strong) KtTableViewDataSource *dataSource;
@property (nonatomic, assign) UITableViewStyle tableViewStyle; // 用来创建 tableView

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
