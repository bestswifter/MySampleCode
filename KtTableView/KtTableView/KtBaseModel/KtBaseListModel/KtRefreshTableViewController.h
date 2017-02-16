//
//  KtRefreshTableViewController.h
//  KtTableView
//
//  Created by bestswifter on 16/5/20.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtTableViewController.h"
#import "KtBaseListModel.h"

@interface KtRefreshTableViewController : KtTableViewController<KtBaseListModelProtocol>

@property (nonatomic, strong) KtBaseListModel *listModel;

- (void)requestDidSuccess; // 子类请求完成后的处理方法。

@end
