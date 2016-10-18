//
//  UIApplication+OBExtend.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 8/13/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import "UIApplication+OBExtend.h"

@implementation UIApplication (OBExtend)

+ (NSString *)ob_appName {
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:(NSString *)kCFBundleNameKey];
}

+ (NSString *)ob_bundleId {
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:(NSString *)kCFBundleIdentifierKey];
}

+ (NSString *)ob_shortVersion {
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)ob_buildVersion {
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:(NSString *)kCFBundleVersionKey];
}

@end
