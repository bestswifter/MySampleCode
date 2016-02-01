//
//  Normal.m
//  load
//
//  Created by 张星宇 on 16/2/1.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "Other.h"
#import <objc/runtime.h>

@implementation Other

static NSString *name;

+ (void)load {
    name = @"Other";
    NSLog(@"Load Class Other");
    
    Method originalFunc = class_getInstanceMethod([self class], @selector(originalFunc));
    Method swizzledFunc = class_getInstanceMethod([self class], @selector(swizzledFunc));
    
    method_exchangeImplementations(originalFunc, swizzledFunc);
}

+ (void)printName {
    NSLog(@"%@",name);
}

- (void)originalFunc {
    NSLog(@"Original Output");
}

- (void)swizzledFunc {
    NSLog(@"Swizzled Output");
}

@end
