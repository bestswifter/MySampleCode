//
//  KtTableViewDataSource.m
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtTableViewDataSource.h"
#import "KtTableViewSectionObject.h"
#import "KtBaseTableViewCell.h"
#import "KtTableViewBaseItem.h"

#import <objc/runtime.h>

@implementation KtTableViewDataSource

#pragma mark - KtTableViewDataSource
- (KtTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sections.count > indexPath.section) {
        KtTableViewSectionObject *sectionObject = [self.sections objectAtIndex:indexPath.section];
        if ([sectionObject.items count] > indexPath.row) {
            return [sectionObject.items objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

- (Class)tableView:(UITableView*)tableView cellClassForObject:(KtTableViewBaseItem *)object {  // 这个方法会子类有机会重写，默认的 Cell 类型是 KtBaseTableViewCell
    return [KtBaseTableViewCell class];
}

- (void)clearAllItems {
    self.sections = [NSMutableArray arrayWithObject:[[KtTableViewSectionObject alloc] init]];
}

- (void)appendItem:(KtTableViewBaseItem *)item {
    KtTableViewSectionObject *firstSectionObject = [self.sections objectAtIndex:0];
    [firstSectionObject.items addObject:item];
}

#pragma mark - UITableViewDataSource Required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sections.count > section) {
        KtTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.items.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KtTableViewBaseItem *object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    
    KtBaseTableViewCell* cell = (KtBaseTableViewCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    [cell setObject:object];
    
    return cell;
}

#pragma mark - UITableViewDataSource Optional
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections ? self.sections.count : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.sections.count > section) {
        KtTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.headerTitle;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.sections.count > section) {
        KtTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        if (sectionObject != nil && sectionObject.footerTitle != nil && ![sectionObject.footerTitle isEqualToString:@""]) {
            return sectionObject.footerTitle;
        }
    }
    return nil;
}


@end
