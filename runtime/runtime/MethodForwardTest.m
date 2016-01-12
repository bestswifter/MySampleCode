//
//  MyTest.m
//  runtime
//
//  Created by 张星宇 on 16/1/2.
//  Copyright © 2016年 张星宇. All rights reserved.
//

#import "MethodForwardTest.h"
#import <objc/runtime.h>
#import "Replacement.h"

/**
 *  这个类用来演示消息转发的过程，在头文件中定义的test方法没有提供实现
 *  消息转发一共有三次机会，注释掉第一次机会相关的代码，就会用到第二次机会。如果所有代码都注释掉就会报错
 */
@implementation MethodForwardTest

/**
 *  第一次机会，动态添加方法
 */
id dynamicMethod(id self, SEL _cmd) {
    NSLog(@"首先尝试动态添加方法");
    return @"首先尝试动态添加方法";
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    
    if ([selectorString isEqualToString:@"test"]) {
        class_addMethod(self, sel, (IMP)dynamicMethod, "@@:");
    }
    
    return YES;
}

/**
 *  第二次机会，方法转发
 *
 *  @param sel 需要处理的方法
 *
 *  @return 能够处理这个方法的对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [[Replacement alloc] init];
}

/**
 *  第三次机会，完整的方法转发
 */
- (void)anotherTest {
    NSLog(@"另一个test方法");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if (!signature) {  // 如果不能处理这个方法
        if ([self respondsToSelector:@selector(anotherTest)]) {
            // 返回另一个函数的方法签名，这个函数不一定要定义在本类中
            signature =  [MethodForwardTest instanceMethodSignatureForSelector:@selector(anotherTest)];
        }
    }
    return signature;
}

/**
 *  这个函数中可以修改很多信息，比如可以替换选方法的处理者，替换选择子，修改参数等等
 *
 *  @param anInvocation 被转发的选择子
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation setSelector:@selector(anotherTest)];  // 设置需要调用的选择子
    [anInvocation invokeWithTarget:self];  // 设置消息的接收者，不一定必须是self
}

@end
