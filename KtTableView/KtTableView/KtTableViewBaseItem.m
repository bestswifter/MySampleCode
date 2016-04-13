//
//  KtTableViewBaseItem.m
//  KtTableView
//
//  Created by baidu on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtTableViewBaseItem.h"

@implementation KtTableViewBaseItem

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage {
    self = [super init];
    if (self) {
        _itemImage = image;
        _itemTitle = title;
        _itemSubtitle = subTitle;
        _itemAccessoryImage = accessoryImage;
    }
    return self;
}

@end
