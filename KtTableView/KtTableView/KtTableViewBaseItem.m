//
//  KtTableViewBaseItem.m
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtTableViewBaseItem.h"

CGFloat const CellInvalidHeight = -1;

@implementation KtTableViewBaseItem

- (instancetype)init {
    self = [self initWithImage:nil Title:nil SubTitle:nil AccessoryImage:nil];
    return self;
}

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage {
    self = [super init];
    if (self) {
        _cellHeight = CellInvalidHeight;
        _itemImage = image;
        _itemTitle = title;
        _itemSubtitle = subTitle;
        _itemAccessoryImage = accessoryImage;
    }
    return self;
}

@end
