//
//  KtBaseTableViewCell.h
//  KtTableView
//
//  Created by baidu on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KtTableViewBaseItem;

@interface KtBaseTableViewCell : UITableViewCell

@property (nonatomic, retain) id object;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(KtTableViewBaseItem *)object;

@end
