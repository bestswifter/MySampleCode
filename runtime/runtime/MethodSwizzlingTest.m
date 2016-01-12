//
//  MethodSwizzlingTest.m
//  runtime
//
//  Created by 张星宇 on 16/1/2.
//  Copyright © 2016年 张星宇. All rights reserved.
//

#import "MethodSwizzlingTest.h"
#import "NSString+MyImplementation.h"
#import <objc/runtime.h>

/**
 *  这个类用来演示Method Swizzle的原理。
 */
@interface MethodSwizzlingTest ()

- (void)startMethodSwizzling;

@end

static NSString *mixedString = @"Hello World";

@implementation MethodSwizzlingTest


/**
 *  理论上来说，应该在load方法中线程安全地进行Method Swizzle，这里为了演示Method Swizzle可以动态进行，
 *  我把startMethodSwizzling函数放在test方法中执行
 */
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method originalLowercaseStringMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
//        Method newLowercaseStringMethod = class_getInstanceMethod([NSString class], @selector(myLowercaseString));
//        
//        method_exchangeImplementations(originalLowercaseStringMethod, newLowercaseStringMethod);
//    });
//}

- (void)test {
    NSLog(@"未进行Method Swizzling之前：");
    NSLog(@"小写字符串：%@", [mixedString lowercaseString]);
    
    [self startMethodSwizzling];
    
    NSLog(@"进行Method Swizzling之后：");
    NSLog(@"小写字符串：%@", [mixedString lowercaseString]);
}

- (void)startMethodSwizzling {
    Method originalLowercaseStringMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method newLowercaseStringMethod = class_getInstanceMethod([NSString class], @selector(myLowercaseString));
    
    method_exchangeImplementations(originalLowercaseStringMethod, newLowercaseStringMethod);
}

@end