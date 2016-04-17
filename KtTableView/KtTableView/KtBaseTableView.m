//
//  KtBaseTableView.m
//  KtTableView
//
//  Created by baidu on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseTableView.h"
#import "KtBaseTableViewCell.h"
#import "KtTableViewSectionObject.h"
#import "KtTableViewBaseItem.h"

@implementation KtBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;
        self.delegate = self;
    }
    return self;
}

- (void)setKtDataSource:(id<KtTableViewDataSource>)ktDataSource {
    if (_ktDataSource != ktDataSource) {
        _ktDataSource = ktDataSource;
        self.dataSource = ktDataSource;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    id<KtTableViewDataSource> dataSource = (id<KtTableViewDataSource>)tableView.dataSource;
    
    KtTableViewBaseItem *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];

    if (object.cellHeight == CellInvalidHeight) { // 没有高度缓存
        object.cellHeight = [cls tableView:tableView rowHeightForObject:object];
    }
    return object.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ktDelegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]) {
        id<KtTableViewDataSource> dataSource = (id<KtTableViewDataSource>)tableView.dataSource;
        id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        [self.ktDelegate didSelectObject:object atIndexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if ([self.ktDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.ktDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.ktDelegate respondsToSelector:@selector(headerViewForSectionObject:atSection:)]) {
        id<KtTableViewDataSource> dataSource = (id<KtTableViewDataSource>)tableView.dataSource;
        KtTableViewSectionObject *sectionObject = [((KtTableViewDataSource *)dataSource).sections objectAtIndex:section];
        
        return [self.ktDelegate headerViewForSectionObject:sectionObject atSection:section];
    }
    else if ([self.ktDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.ktDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

#pragma mark - 传递原生协议

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.ktDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.ktDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
@end
