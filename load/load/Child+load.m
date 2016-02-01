//
//  Child+load.m
//  load
//
//  Created by 张星宇 on 16/2/1.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "Child+load.h"

@implementation Child (load)

+ (void)load {
    /**
     *  分类中的load方法会被调用
     */
    NSLog(@"Load Class Child+load");
}

/**
 *  initialize更像是一个普通的方法。
 *  即使在Child.m中实现了initialize方法，也会在这里被覆盖
 */
//+ (void)initialize {
//    NSLog(@"Initialize Class Child+load");
//}

@end
