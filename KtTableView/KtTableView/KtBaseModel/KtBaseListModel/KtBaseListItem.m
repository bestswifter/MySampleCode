//
//  KtBaseListItem.m
//  KtTableView
//
//  Created by bestswifter on 16/5/18.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseListItem.h"

@implementation KtBaseListItem

- (id)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        self.pageNumber = [[NSString stringWithFormat:@"%@", [data objectForKey:@"page_number"]] intValue];
    }
    return self;
}

@end
