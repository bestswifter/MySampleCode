//
//  KtBaseTableViewCell.m
//  KtTableView
//
//  Created by baidu on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseTableViewCell.h"
#import "KtTableViewBaseItem.h"
#import "UIView+KtExtension.h"

@implementation KtBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(KtTableViewBaseItem *)object { // 子类在这个方法中解析数据
    self.imageView.image = object.itemImage;
    self.textLabel.text = object.itemTitle;
    self.detailTextLabel.text = object.itemSubtitle;
    self.accessoryView = [[UIImageView alloc] initWithImage:object.itemAccessoryImage];
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(KtTableViewBaseItem *)object {
    return 44.0f;
}

@end
