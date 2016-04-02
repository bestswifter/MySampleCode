//
//  EOCErrors.h
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/27.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCErrors : NSObject

extern NSString *const EOCErrorDomain;

typedef NS_ENUM(NSUInteger, EOCError) {
    EOCErrorUnkonwn               = -1,
    EOCErrorInternalInconsistency = 100,
    EOCErrorGeneralFault          = 105,
    EOCErrorBadInput              = 500,
};

@end
