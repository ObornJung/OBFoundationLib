//
//  NSArray+OBExtend.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 12/2/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

#import "NSArray+OBExtend.h"

@implementation NSArray (OBExtend)

- (NSArray *)ob_deepCopy {
    
    NSMutableArray * copyArray = [self mutableCopy];
    [self enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL * stop) {
        id copyValue = nil;
        if ([value respondsToSelector:@selector(ob_deepCopy)]) {
            copyArray[idx] = [value ob_deepCopy];
        } else if ([value respondsToSelector:@selector(copyWithZone:)]) {
            copyArray[idx] = [value copy];
        }
        if(copyValue!=nil) {
            copyArray[idx] = copyValue;
        }
    }];
    return [copyArray copy];
}

- (NSMutableArray *)ob_mutableDeepCopy {
    
    NSMutableArray * copyArray = [self mutableCopy];
    [self enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL * stop) {
        id copyValue;
        if ([value respondsToSelector:@selector(ob_mutableDeepCopy)]) {
            copyValue = [value ob_mutableDeepCopy];
        } else if ([value respondsToSelector:@selector(mutableCopyWithZone:)]) {
            copyValue = [value mutableCopy];
        } else if ([value respondsToSelector:@selector(copyWithZone:)]) {
            copyValue = [value copy];
        }
        if(copyValue!=nil) {
            copyArray[idx] = copyValue;
        }
    }];
    return copyArray;
}

@end
