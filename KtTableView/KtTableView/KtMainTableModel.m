//
//  KtMainTableModel.m
//  KtTableView
//
//  Created by bestswifter on 16/5/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtMainTableModel.h"
#import "KtMainTableItem.h"

@implementation KtMainTableModel

- (void)handleParsedData:(KtBaseItem *)parsedData {
    [super handleParsedData:parsedData];
    if ([parsedData isKindOfClass:[KtMainTableItem class]]) {
        self.tableViewItem = (KtMainTableItem *)parsedData;
    }
}

- (void)loadWithShortConnection {
    if (!self.parseDataClassType) {
        self.parseDataClassType = [KtMainTableItem class];
    }
    [super loadWithShortConnection];
}

@end
