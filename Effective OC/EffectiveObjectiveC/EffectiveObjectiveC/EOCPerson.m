//
//  EOCPerson.m
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/24.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "EOCPerson.h"
#import "EOCEmployee.h"
#import <objc/runtime.h>

// 变量的作用范围只在这个目标文件中，如果不加 static，会产生外部符号，然后报错
static int EOCConst = 1;

NSString *const EOCStringConstant = @"StringValue";

@implementation EOCPerson 

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.firstName = @"EOCPerson-FirstName";
        self.lastName = @"EOCPerson-LastName";
        NSString *associatedString = @"associatedString";
        objc_setAssociatedObject(self, EOCMyKey, associatedString, OBJC_ASSOCIATION_COPY);
    }
    return self;
}

- (NSUInteger)hash {
    static int hashValue = 0;
    return hashValue++;
//    return 1337;
//    return [self.firstName hash] ^ [self.lastName hash];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if ([self class] != [object class]) {
        return NO;
    }
    
    EOCPerson *anotherPerson = (EOCPerson *)object;
    return [self.firstName isEqualToString:anotherPerson.firstName] &&
            [self.lastName isEqualToString:anotherPerson.lastName];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, %@", _firstName, _lastName];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p, \"%@ %@\">", [self class], self, _firstName, _lastName];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EOCPerson *copy = [[EOCPerson allocWithZone:zone] init];
    copy.lastName = self.lastName;
    copy.firstName = self.firstName;
    copy.employee= [self.employee copy];
    
    return copy;
}

@end
