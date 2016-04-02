//
//  main.m
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/24.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "Literal.h"
#import "EOCPerson.h"
#import "EOCSmithPerson.h"
#import "HashTest.h"
#import "EOCEmployee.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Literal *l = [[Literal alloc] init];
        NSLog(@"%@\n%@", l.animals, l.personData);
        
        EOCSmithPerson *smith = [[EOCSmithPerson alloc] init];
        NSLog(@"%@", smith.lastName);
        
        HashTest *test = [[HashTest alloc] init];
        [test testMutableCollection];
        
        EOCEmployee *employee = [EOCEmployee employeeWithType:EOCEmployeeTypeDeveloper];
        [employee doSomeWork];
        NSLog(@"%@ member of", [employee isMemberOfClass:[EOCEmployee class]] ? @"is " : @"not");
        NSLog(@"%@ kind of", [employee isKindOfClass:[EOCEmployee class]] ? @"is" : @"not");
        
        EOCPerson *person = [[EOCPerson alloc] init];
        NSLog(@"associated string = %@", objc_getAssociatedObject(person, EOCMyKey));
        NSLog(@"person = %@", person);

    }
    return 0;
}
