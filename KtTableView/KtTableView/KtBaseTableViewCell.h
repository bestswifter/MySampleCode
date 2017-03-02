//
//  KtBaseTableViewCell.h
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KtTableViewBaseItem;

@interface KtBaseTableViewCell : UITableViewCell

/**
 *  子类通过该方法传入Item
 *
 *  @param object 用于展示的数据源
 */
- (void)setObject:(KtTableViewBaseItem *)object;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(KtTableViewBaseItem *)object;

@end
