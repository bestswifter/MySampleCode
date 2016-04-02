//
//  EOCSmithPerson.m
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/24.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "EOCSmithPerson.h"
#import "EOCErrors.h"

@implementation EOCSmithPerson

@synthesize lastName = _lastName;

- (void)setLastName:(NSString *)lastName {
    if (![lastName isEqualToString:@"Smith"]) {
        // 会执行到这段代码
//        [NSException raise:NSInvalidArgumentException format:@"Last name must be Smith"];
    }
    
    _lastName = lastName;
}

- (bool) doSomething:(NSError **)error {
    if (![self.firstName isEqualToString:@""]) {
        if (error) {
            *error = [NSError errorWithDomain:EOCErrorDomain
                                         code:EOCErrorUnkonwn
                                     userInfo:nil];
        }
        return NO;
    }
    else {
        return YES;
    }
}

@end
