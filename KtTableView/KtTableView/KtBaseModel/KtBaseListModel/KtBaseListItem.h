//
//  KtBaseListItem.h
//  KtTableView
//
//  Created by bestswifter on 16/5/18.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseItem.h"

@interface KtBaseListItem : KtBaseItem

//@property (nonatomic, assign) int hasNext;
//@property (nonatomic, assign) int hasPrev;
@property (nonatomic, assign) int pageNumber; // 为了简化问题，我们让客户端直接传这个值，其实应该用上面两个。

@end
