//
//  Parent.m
//  load
//
//  Created by 张星宇 on 16/2/1.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "Parent.h"

static int someNumber = 0;
static NSMutableArray *someObjects;

@implementation Parent

+ (void)load {
    NSLog(@"Load Class Parent");
}

+ (void)initialize {
    NSLog(@"Initialize Parent, caller Class %@", [self class]);
}

/**
 *  下面这个才是正确的initialize方法的实现，需要判断是不是由自己这个类调用的。
 */
+ (void)initializeCorrect {
    if (self == [Parent class]) {
        someObjects = [[NSMutableArray alloc] init];    // 不方便编译期复制的对象在这里赋值
        NSLog(@"Initialize Parent, caller Class %@", [self class]);
    }
}

@end
