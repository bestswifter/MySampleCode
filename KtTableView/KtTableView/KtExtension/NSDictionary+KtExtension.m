//
//  NSDictionary+KtExtension.m
//  KtTableView
//
//  Created by bestswifter on 16/5/15.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "NSDictionary+KtExtension.h"

@implementation NSDictionary (KtExtension)

- (NSObject *)objectAtPath:(NSString *)path {
    NSArray * array = [path componentsSeparatedByString:@"/"];
    if ( 0 == [array count] ) {
        return nil;
    }
    
    NSObject * result = nil;
    NSDictionary * dict = self;
    
    for ( NSString * subPath in array ) {
        if ( 0 == [subPath length] )
            continue;
        
        result = [dict objectForKey:subPath];
        if ( nil == result ) {
            return nil;
        }
        if ( [array lastObject] == subPath) {
            return result;
        }
        else if ( NO == [result isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        dict = (NSDictionary *)result;
    }
    
    return (result == [NSNull null]) ? nil : result;
}

- (NSObject *)objectAtPath:(NSString *)path otherwise:(NSObject *)other {
    NSObject * obj = [self objectAtPath:path];
    return obj ? obj : other;
}

- (BOOL)boolAtPath:(NSString *)path {
    return [self boolAtPath:path otherwise:NO];
}

- (BOOL)boolAtPath:(NSString *)path otherwise:(BOOL)other {
    NSObject * obj = [self objectAtPath:path];
    if ( [obj isKindOfClass:[NSNull class]] ) {
        return NO;
    }
    else if ( [obj isKindOfClass:[NSNumber class]] ) {
        return [(NSNumber *)obj intValue] ? YES : NO;
    }
    else if ( [obj isKindOfClass:[NSString class]] ) {
        if ( [(NSString *)obj hasPrefix:@"y"] ||
            [(NSString *)obj hasPrefix:@"Y"] ||
            [(NSString *)obj hasPrefix:@"T"] ||
            [(NSString *)obj hasPrefix:@"t"] ||
            [(NSString *)obj isEqualToString:@"1"] ) {
            // YES/Yes/yes/TRUE/Ture/true/1
            return YES;
        }
        else {
            return NO;
        }
    }
    
    return other;
}

- (NSNumber *)numberAtPath:(NSString *)path {
    NSObject * obj = [self objectAtPath:path];
    if ( [obj isKindOfClass:[NSNull class]] ) {
        return nil;
    }
    else if ( [obj isKindOfClass:[NSNumber class]] ) {
        return (NSNumber *)obj;
    }
    else if ( [obj isKindOfClass:[NSString class]] ) {
        return [NSNumber numberWithDouble:[(NSString *)obj doubleValue]];
    }
    
    return nil;
}

- (NSNumber *)numberAtPath:(NSString *)path otherwise:(NSNumber *)other {
    NSNumber * obj = [self numberAtPath:path];
    return obj ? obj : other;
}

- (NSString *)stringAtPath:(NSString *)path {
    NSObject * obj = [self objectAtPath:path];
    if ( [obj isKindOfClass:[NSNull class]] ) {
        return nil;
    }
    else if ( [obj isKindOfClass:[NSNumber class]] ) {
        return [NSString stringWithFormat:@"%lld", [(NSNumber *)obj longLongValue]];
    }
    else if ( [obj isKindOfClass:[NSString class]] ) {
        return (NSString *)obj;
    }
    
    return nil;
}

- (NSString *)stringAtPath:(NSString *)path otherwise:(NSString *)other {
    NSString * obj = [self stringAtPath:path];
    return obj ? obj : other;
}

- (NSArray *)arrayAtPath:(NSString *)path {
    NSObject * obj = [self objectAtPath:path];
    return [obj isKindOfClass:[NSArray class]] ? (NSArray *)obj : nil;
}

- (NSArray *)arrayAtPath:(NSString *)path otherwise:(NSArray *)other {
    NSArray * obj = [self arrayAtPath:path];
    return obj ? obj : other;
}

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path {
    NSObject * obj = [self objectAtPath:path];
    return [obj isKindOfClass:[NSMutableArray class]] ? (NSMutableArray *)obj : nil;
}

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path otherwise:(NSMutableArray *)other {
    NSMutableArray * obj = [self mutableArrayAtPath:path];
    return obj ? obj : other;
}

- (NSDictionary *)dictAtPath:(NSString *)path {
    NSObject * obj = [self objectAtPath:path];
    return [obj isKindOfClass:[NSDictionary class]] ? (NSDictionary *)obj : nil;
}

- (NSDictionary *)dictAtPath:(NSString *)path otherwise:(NSDictionary *)other {
    NSDictionary * obj = [self dictAtPath:path];
    return obj ? obj : other;
}

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path {
    NSObject * obj = [self objectAtPath:path];
    return [obj isKindOfClass:[NSMutableDictionary class]] ? (NSMutableDictionary *)obj : nil;
}

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path otherwise:(NSMutableDictionary *)other {
    NSMutableDictionary * obj = [self mutableDictAtPath:path];
    return obj ? obj : other;
}

-(NSData*)data {
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

@end

#pragma mark -

@implementation NSMutableDictionary (IDPExtension)
- (void)safeSetObject:(id)anObject forKey:(id < NSCopying >)aKey {
    if (!anObject || !aKey) {
        return ;
    }
    [self setObject:anObject forKey:aKey];
}

- (void)safeSetObject:(id)object forKeyedSubscript:(id < NSCopying >)aKey {
    if (!object || !aKey) {
        return ;
    }
    [self setObject:object forKeyedSubscript:aKey];
}

- (void)safeRemoveObjectForKey:(id)aKey {
    if(!aKey)
        return;
    [self removeObjectForKey:aKey];
}

@end
