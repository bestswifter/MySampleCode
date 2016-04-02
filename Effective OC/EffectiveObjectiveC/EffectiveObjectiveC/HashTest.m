//
//  HashTest.m
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/25.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "HashTest.h"
#import "EOCPerson.h"

@implementation HashTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        EOCPerson *person1 = [[EOCPerson alloc] init];
        EOCPerson *person2 = [[EOCPerson alloc] init];
        NSLog(@"person1.hashValue = %lu", (unsigned long)[person1 hash]);
        NSLog(@"person2.hashValue = %lu", (unsigned long)[person2 hash]);
        
        if ([person1 isEqual:person2]) {
            NSLog(@"Person1 and Person2 is the same");
        }
        else {
            NSLog(@"Person1 and Person2 is not the same");
        }
    }
    return self;
}

- (void)testMutableCollection {
    NSMutableSet *set = [NSMutableSet new];
    
    NSMutableArray *arrayA = [@[@1, @2] mutableCopy];
    [set addObject:arrayA];
    
    NSMutableArray *arrayB = [@[@1, @2] mutableCopy];
    [set addObject:arrayB];
    
    NSMutableArray *arrayC = [@[@1] mutableCopy];
    [set addObject:arrayC];
    
    [arrayC addObject:@2];
    NSLog(@"set = %@", set);
}

@end
