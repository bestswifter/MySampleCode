//
//  EOCEmployee.m
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/24.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "EOCEmployee.h"
#import "EOCEmployeeDeveloper.h"
#import "EOCEmployeeFinance.h"
#import "EOCEmployeeDesigner.h"

int EOCConst = 1;

@implementation EOCEmployee

- (void)addEmployee:(EOCPerson *)person {
    return;
}

- (void)doSomeWork {
    return;
}

+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type {
    switch (type) {
        case EOCEmployeeTypeDeveloper:
            return [EOCEmployeeDeveloper new];
            break;
        case EOCEmployeeTypeFinance:
            return [EOCEmployeeFinance new];
            break;
        case EOCEmployeeTypeDesigner:
            return [EOCEmployeeDesigner new];
            break;
    }
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [[EOCEmployee allocWithZone:zone] init];
}

@end
