//
//  main.m
//  runtime
//
//  Created by 张星宇 on 16/1/2.
//  Copyright © 2016年 张星宇. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MethodForwardTest.h"
#import "MethodSwizzlingTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MethodForwardTest *methodForward = [[MethodForwardTest alloc] init];
        [methodForward test];  // test 方法只有定义没有实现，需要进行消息转发
        
        MethodSwizzlingTest *methodSwizzling = [[MethodSwizzlingTest alloc] init];
        [methodSwizzling test];  // 演示Method Swizzling的实现
    }
    return 0;
}

