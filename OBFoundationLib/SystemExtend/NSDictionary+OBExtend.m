//
//  NSDictionary+OBExtend.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 12/1/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

#import "NSDictionary+OBExtend.h"

@implementation NSDictionary (OBExtend)

+ (instancetype)ob_dictionaryWithJsonFile:(NSString *)fileName {
    if (fileName.length > 0) {
        NSString * filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@""];
        NSData * data = [NSData dataWithContentsOfFile:filePath];
        return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    return nil;
}

+ (NSDictionary *)ob_dictionaryWithJSONString:(NSString *)JSONString {
    NSData * JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
}

- (NSDictionary *)ob_deepCopy {
    
    NSMutableDictionary * copyDict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    for (id key in [self allKeys]) {
        id value = [self objectForKey:key];
        id copyValue = value;
        if ([value respondsToSelector:@selector(ob_deepCopy)]) {
            copyValue = [value ob_deepCopy];
        } else if ([value respondsToSelector:@selector(copyWithZone:)]) {
            copyValue = [value copy];
        }
        copyDict[key] = copyValue;
    }
    return [copyDict copy];
}

- (NSMutableDictionary *)ob_mutableDeepCopy {
    
    NSMutableDictionary * copyDict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    for (id key in [self allKeys]) {
        id value = [self objectForKey:key];
        id copyValue = value;
        if ([value respondsToSelector:@selector(ob_mutableDeepCopy)]) {
            copyValue = [value ob_mutableDeepCopy];
        } else if ([value respondsToSelector:@selector(mutableCopyWithZone:)]) {
            copyValue = [value mutableCopy];
        } else if ([value respondsToSelector:@selector(copyWithZone:)]) {
            copyValue = [value copy];
        }
        copyDict[key] = copyValue;
    }
    return copyDict;
}

@end
