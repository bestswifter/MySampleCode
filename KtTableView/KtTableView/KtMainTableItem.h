//
//  KtMainTableItem.h
//  KtTableView
//
//  Created by bestswifter on 16/5/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseListItem.h"

@interface KtMainTableItem : KtBaseListItem

@property (strong, nonatomic) NSMutableArray *books; // 存放了每个 cell 的标题

@end

@interface KtMainTableBookItem : KtBaseItem

@property (copy, nonatomic) NSString *bookTitle;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *imageUrl;

@end
