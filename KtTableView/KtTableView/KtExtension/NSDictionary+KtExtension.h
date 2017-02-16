//
//  NSDictionary+KtExtension.h
//  KtTableView
//
//  Created by bestswifter on 16/5/15.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KtExtension)

/*!
 @brief   根据路径获取obj 例如path为test/xxx/vallue, 会从dict中找到key为test的dict, 在test的dict中找到key为xxx的dict 在xxx的dict中找到key为value的对象
 @param   path  给定的路径 eg. test/xxx/value
 @return  返回obj or nil
 */
- (NSObject *)objectAtPath:(NSString *)path;

/*!
 @brief   根据路径获取obj 如果获取不到返回other
 @param   path  给定的路径
 @param   other 默认值，当找不到给定的obj，返回other
 @return  返回obj or other
 */
- (NSObject *)objectAtPath:(NSString *)path otherwise:(NSObject *)other;

/*!
 @brief   判断给定的key值是否为BOOL类型
 @param   path  给定的路径
 @return  YES or NO
 */
- (BOOL)boolAtPath:(NSString *)path;

/*!
 @brief   判断给定的key值是否为BOOL类型，如果给定的路径中找不到key值，返回other
 @param   path  给定的路径 @param   other  默认值，当找不到给定的obj，返回other
 @return  判断结果
 */
- (BOOL)boolAtPath:(NSString *)path otherwise:(BOOL)other;

/*!
 @brief   获取给定的key值，返回类型为number
 @param   path  给定的路径
 @return  key值 or nil
 */
- (NSNumber *)numberAtPath:(NSString *)path;


/*!
 @brief   获取给定的key值，返回类型为number
 @param   path  给定的路径
 @param   otherwise  默认值，当找不到给定的obj，返回other
 @return  key值 or other
 */
- (NSNumber *)numberAtPath:(NSString *)path otherwise:(NSNumber *)other;


/*!
 @brief   获取给定的key值，返回类型为String
 @param   path  给定的路径
 @return  key值 or nil
 */
- (NSString *)stringAtPath:(NSString *)path;

/*!
 @brief   获取给定的key值，返回类型为string
 @param   path  给定的路径
 @param   otherwise  默认值，当找不到给定的obj，返回otherwise
 @return  key值 or otherwise
 */
- (NSString *)stringAtPath:(NSString *)path otherwise:(NSString *)other;

/*!
 @brief   获取给定的key值，返回类型为NSArray
 @param   path:给定的路径
 @return  key值 or nil
 */
- (NSArray *)arrayAtPath:(NSString *)path;

/*!
 @brief   获取给定的key值，返回类型为NSArray
 @param   path  给定的路径
 @param   otherwise  默认值，当找不到给定的obj，返回otherwise
 @return  key值 or otherwise
 */
- (NSArray *)arrayAtPath:(NSString *)path otherwise:(NSArray *)other;

/*!
 @brief   获取给定的key值，返回类型为NSMutableArray
 @param   path:给定的路径
 @return  key值 or nil
 */
- (NSMutableArray *)mutableArrayAtPath:(NSString *)path;

/*!
 @brief   获取给定的key值，返回类型为NSMutableArray
 @param   path:给定的路径
 @param   otherwise:默认值，当找不到给定的obj，返回otherwise
 @return  key值 or otherwise
 */
- (NSMutableArray *)mutableArrayAtPath:(NSString *)path otherwise:(NSMutableArray *)other;

//有类型检查的获取NSDictionary类型 否则返回other
/*!
 @brief   通过给定的path获取NSDictionary
 @param   path:给定的路径
 @return  key值 or nil
 */
- (NSDictionary *)dictAtPath:(NSString *)path;

/*!
 @brief   通过给定的path获取NSDictionary
 @param   path:给定的路径
 @param   otherwise:默认值，当找不到给定的obj，返回otherwise
 @return  key值 or otherwise
 */
- (NSDictionary *)dictAtPath:(NSString *)path otherwise:(NSDictionary *)other;

/*!
 @brief   通过给定的path获取NSMutableDictionary
 @param   path:给定的路径
 @return  key值 or nil
 */
- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path;

/*!
 @brief   通过给定的path获取NSMutableDictionary
 @param   path:给定的路径
 @param   otherwise:默认值，当找不到给定的obj，返回otherwise
 @return  key值 or otherwise
 */
- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path otherwise:(NSMutableDictionary *)other;

/*!
 @brief   将当前数据转换为NSData，包含编码格式
 @return  NSData类型的数据
 */
-(NSData*)data;

@end

#pragma mark NSMutableDictionary接口
///NSMutableDictionary接口
@interface NSMutableDictionary (IDPExtension)

/*!
 @brief  安全添加键值对
 @param  anObject: value
 @param  forKey:key
 */
- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

/*!
 @brief  安全添加键值对
 @param  anObject: value
 @param  forKey:key
 */
- (void)safeSetObject:(id)object forKeyedSubscript:(id < NSCopying >)aKey;

/*!
 @brief  安全移除key
 @param  forKey:key
 */
- (void)safeRemoveObjectForKey:(id)aKey;

@end
