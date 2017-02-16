//
//  KtBaseItem.h
//  KtTableView
//
//  Created by bestswifter on 16/5/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KtBaseItem : NSObject

- (id)initWithData:(NSDictionary *)data;

// property中如有包含TBCBaseListItem对象的数组，需要设定此规则
- (void)addMappingRuleArrayProperty:(NSString*)propertyName class:(Class)cls;
// 所有需要映射的property都需要设定此规则
- (void)addMappingRuleProperty:(NSString*)propertyName pathInJson:(NSString*)path;

- (id)setData:(id)data;

@end

@interface KtClassHelper : NSObject

+ (KtClassHelper *)sharedInstance;

@property (nonatomic, retain) NSMutableDictionary *propertyListCache;

- (NSDictionary *)propertyList:(Class)cls;

@end
