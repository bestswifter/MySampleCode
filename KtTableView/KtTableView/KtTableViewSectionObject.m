//
//  KtTableViewSectionObject.m
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtTableViewSectionObject.h"

@implementation KtTableViewSectionObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.headerTitle = @"";
        self.footerTitle = @"";
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithItemArray:(NSMutableArray *)items {
    self = [self init];
    if (self) {
        [self.items addObjectsFromArray:items];
    }
    return self;
}

@end
