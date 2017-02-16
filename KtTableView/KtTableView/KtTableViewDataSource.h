//
//  KtTableViewDataSource.h
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KtTableViewBaseItem;

@protocol KtTableViewDataSource <UITableViewDataSource>

@optional

- (KtTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableView:(UITableView*)tableView cellClassForObject:(KtTableViewBaseItem *)object;

@end

@interface KtTableViewDataSource : NSObject<KtTableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sections;  // 二维数组，每个元素都是一个 SectionObject

- (void)clearAllItems;
- (void)appendItem:(KtTableViewBaseItem *)item;

@end
