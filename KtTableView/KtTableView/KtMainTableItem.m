//
//  KtMainTableItem.m
//  KtTableView
//
//  Created by bestswifter on 16/5/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtMainTableItem.h"

@implementation KtMainTableItem

- (id)init {
    self = [super init];
    if (self) {
        [self addMappingRuleProperty:@"books" pathInJson:@"data"];
        [self addMappingRuleArrayProperty:@"books" class:[KtMainTableBookItem class]];
    }
    return self;
}

@end

@implementation KtMainTableBookItem

- (id)init {
    self = [super init];
    if (self) {
        [self addMappingRuleProperty:@"bookTitle" pathInJson:@"title"];
        [self addMappingRuleProperty:@"url" pathInJson:@"url"];
        [self addMappingRuleProperty:@"imageUrl" pathInJson:@"imageUrl"];
    }
    return self;
}

@end
