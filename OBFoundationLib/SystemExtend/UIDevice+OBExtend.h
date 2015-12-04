//
//  UIDevice+OBExtend.h
//  OBFoundationLib
//
//  Created by Oborn.Jung on 8/20/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (OBExtend)
/**
 *  获取设备UDID
 *
 *  @return 设备UDID
 */
+ (NSString *)ob_UDID;
/**
 *  获取设备总内存，单位:M
 *
 *  @return 设备总内存
 */
+ (double)ob_realMemory;
/**
 *  获取设备当前使用内存，单位:M
 *
 *  @return 设备当前使用内存
 */
+ (double)ob_usedMemory;
/**
 *  获取设备是否越狱
 *
 *  @return 设备是否越狱
 */
+ (BOOL)ob_isJailBreak;
/**
 *  开关手电筒
 *
 *  @param on 是否开关手电筒
 */
+ (void)ob_torchTurnOn:(BOOL)on;

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 *
 *  @return 是否拨号成功
 */
+ (BOOL)ob_dialTelephone:(NSString *)phoneNumber;

@end
