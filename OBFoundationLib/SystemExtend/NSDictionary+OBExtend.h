//
//  NSDictionary+OBExtend.h
//  OBFoundationLib
//
//  Created by Oborn.Jung on 12/1/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (OBExtend)
/**
 *  从json文件中实例化一个dictionary
 *
 *  @param fileName 文件名
 *
 *  @return 实例化的dictionary
 */
+ (instancetype)ob_dictionaryWithJsonFile:(NSString *)fileName;

/**
 *  从jsonString中实例化一个dictionary
 *
 *  @param JSONString json string
 *
 *  @return 实例化的dictionary
 */
+ (NSDictionary *)ob_dictionaryWithJSONString:(NSString *)JSONString;

- (NSDictionary *)ob_deepCopy;

- (NSMutableDictionary *)ob_mutableDeepCopy;

@end
