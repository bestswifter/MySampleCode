//
//  KtRefreshTableViewController.h
//  KtTableView
//
//  Created by baidu on 16/5/20.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtTableViewController.h"
#import "KtBaseListModel.h"

@interface KtRefreshTableViewController : KtTableViewController<KtBaseListModelProtocol>

@property (nonatomic, strong) KtBaseListModel *listModel;

@end
