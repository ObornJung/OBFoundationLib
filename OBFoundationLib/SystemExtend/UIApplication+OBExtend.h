//
//  UIApplication+OBExtend.h
//  OBFoundationLib
//
//  Created by Oborn.Jung on 8/13/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (OBExtend)

+ (NSString *)ob_appName;

+ (NSString *)ob_bundleId;

+ (NSString *)ob_shortVersion;

+ (NSString *)ob_buildVersion;

@end
