//
//  Child.m
//  load
//
//  Created by 张星宇 on 16/2/1.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "Child.h"
#import "Other.h"

@implementation Child

+ (void)load {
    NSLog(@"Load Class Child");
    
    /**
     *  这时候Other类还没调用load方法，所以输出结果是Original Output
     */
    Other *other = [Other new];
    [other originalFunc];
    
    // 如果不先调用other的load，下面这行代码就无效，打印出null
    [Other printName];
}

//+ (void)initialize {
//    NSLog(@"Initialize Child, caller Class %@", [self class]);
//}

@end
