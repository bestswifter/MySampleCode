//
//  Normal.m
//  load
//
//  Created by 张星宇 on 16/2/1.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "Other.h"

@implementation Other

static NSString *name;

+ (void)load {
    name = @"Other";
    NSLog(@"Load Class Normal");
}

+ (void)printName {
    NSLog(@"%@",name);
}

@end
