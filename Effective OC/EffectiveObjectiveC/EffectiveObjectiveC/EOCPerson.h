//
//  EOCPerson.h
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/24.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>
// 引入这行代码会导致两个头文件互相引用
//#import "EOCEmployer.h"
@class EOCEmployee;

// 不要在头文件中使用 static，否则会变成全局变量，放在实现文件里面即可
static const int ANIMATION_DURATION = 1;
static int ANOTHER_DURATION = 2;
static void * const EOCMyKey = @"EOCMyKey";

FOUNDATION_EXPORT NSString *const EOCStringConstant;

@interface EOCPerson : NSObject<NSCopying>

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, strong) EOCEmployee *employee;

@end
