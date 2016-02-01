//
//  main.m
//  load
//
//  Created by 张星宇 on 16/2/1.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Child.h"
#import "Other.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Main函数在这里开始");
        /**
         *  这会触发Child和父类的initialize方法
         */
        Child *child = [Child new];
        
        /**
         *  这时候other已经调用过load方法，所以输出结果是Swizzled Output
         */
        Other *other = [Other new];
        [other originalFunc];
    }
    return 0;
}
