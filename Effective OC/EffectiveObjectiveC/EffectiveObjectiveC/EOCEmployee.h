//
//  EOCEmployee.h
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/24.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EOCPerson.h"

typedef NS_ENUM(NSUInteger, EOCEmployeeType) {
    EOCEmployeeTypeDeveloper,
    EOCEmployeeTypeDesigner,
    EOCEmployeeTypeFinance,
};

@interface EOCEmployee : NSObject <NSCopying>

- (void) addEmployee:(EOCPerson *)person;
- (void) doSomeWork;

+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type;

@end
