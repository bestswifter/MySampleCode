//
//  OCEnum.m
//  Enum
//
//  Created by 张星宇 on 16/1/12.
//  Copyright © 2016年 张星宇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MyEnum) {
    //以下是枚举成员
    ValueA = 1,  // 如果不写值，默认为1，这是枚举的原始值
    ValueB, // 默认是ValueA的值加1
    ValueC, // 默认是ValueB的值加1，以此类推
    ValueD
};