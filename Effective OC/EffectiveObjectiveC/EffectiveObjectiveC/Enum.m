//
//  Enum.m
//  EffectiveObjectiveC
//
//  Created by 张星宇 on 16/3/24.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "Enum.h"

@implementation Enum

// 可以声明枚举变量的类型
enum EOCConnectionState: NSInteger {
    ECOConnectStateDisconnected = 1, // 不指定值的时候默认是 0，然后下面的依次递增
    ECOConnectStateConnecting = 2,
    ECOConnectStateConnected = 3
};

// 常规写法
enum EOCConnectionState state = ECOConnectStateConnected;

// 用了 typedef 简化语法
typedef enum EOCConnectionState EOCConnectionState;
EOCConnectionState state2 = ECOConnectStateConnecting;

// 使用 NS_ENUM 宏
typedef NS_ENUM(NSInteger, EOCEnumType) {
    EOCEnumTypeA,
    EOCEnumTypeB,
    EOCEnumTypeC
};

EOCEnumType type = EOCEnumTypeA;

// 使用 NS_OPTION 宏
typedef NS_ENUM(NSInteger, EOCOptionType) {
    EOCOptionTypeA,
    EOCOptionTypeB,
    EOCOptionTypeC
};

EOCOptionType option = EOCOptionTypeA;

@end
