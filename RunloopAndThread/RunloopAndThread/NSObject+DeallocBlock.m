//
//  NSObject+DeallocBlock.m
//  pengpeng
//
//  Created by jianwei.chen on 15/9/6.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import "NSObject+DeallocBlock.h"
#import <objc/message.h>

@interface NBDeallocBlockExecutor : NSObject{
    dispatch_block_t _block;
}
- (id)initWithBlock:(dispatch_block_t)block;
@end

@implementation NBDeallocBlockExecutor
- (id)initWithBlock:(dispatch_block_t)aBlock
{
    self = [super init];
    if (self) {
        _block = [aBlock copy];
    }
    return self;
}
- (void)dealloc
{
    _block ? _block() : nil;
}
@end


static char *dealloc_key;
@implementation NSObject (DeallocBlock)

-(void)runAtDealloc:(dispatch_block_t)block
{
    if(block){
        NBDeallocBlockExecutor *executor = [[NBDeallocBlockExecutor alloc] initWithBlock:block];
        objc_setAssociatedObject(self, &dealloc_key, executor, OBJC_ASSOCIATION_RETAIN);//不要强应用
    }
}

@end
