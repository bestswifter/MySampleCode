//
//  Literal.m
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/24.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "Literal.h"
#import "EOCPerson.h"

@implementation Literal

- (instancetype)init
{
    self = [super init];
    if (self) {
        EOCPerson *p = nil;
        // 如果有变量为 nil，使用字面量语法会导致运行时崩溃
//        self.animals = @[@"dog", @"cat", p, @"mouse"];
        self.animals = [NSArray arrayWithObjects:@"dog", @"cat", p, @"mouse", nil];
        
        // 直接写 nil 会导致编译错误，需要注意变量为 nil 的情况
//        self.animals = @[@"dog", @"cat", p, @"mouse"];
        
        // 字典与数组同理
        self.personData = [NSDictionary dictionaryWithObjectsAndKeys:@"Matt", @"firstName",
                                                                     p, @"person",
                                                                     @"Galloway", @"lastName",nil];
//        self.personData = @{@"Matt" : @"firstName",
//                            p : @"person",
//                            @"Galloway" : @"lastName"};
        NSLog(@"%d, %d, %@", ANIMATION_DURATION, ANOTHER_DURATION, EOCStringConstant);
    }
    return self;
}

@end
