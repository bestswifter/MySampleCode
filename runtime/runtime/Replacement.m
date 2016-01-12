//
//  Replacement.m
//  runtime
//
//  Created by 张星宇 on 16/1/2.
//  Copyright © 2016年 张星宇. All rights reserved.
//

#import "Replacement.h"

/**
 *  这个类配合MethodForwardTest使用。它实现了test，所以MethodForwardTest可以把方法转发给这个类
 *  的实例对象来处理
 */
@implementation Replacement

- (void)test {
    NSLog(@"备用实现者提供了test方法的实现");
}

@end
