//
//  NSString+OBExtend.h
//  OBFoundationLib
//
//  Created by ObornJung@foxmail.com on 8/20/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class UIFont;

@interface NSString (OBExtend)

/**
 * Calculate the md5 encrypted string of this string using CC_MD5.
 *
 * @return md5 encrypted this string
 */
@property (nonatomic, readonly) NSString    * ob_md5;

/**
 *  去除掉NSString中的"-","+"," ","<",">"
 *
 *  @param phoneNumber 未处理的string
 *
 *  @return 处理后的string
 */
+ (NSString *)ob_phoneNumberRegularization:(NSString *)phoneNumber;

/**
 *  计算字符串在给定的font和width需要的高度
 *
 *  @param font  字体
 *  @param width 限定宽度
 *
 *  @return 需要显示所有字符的高度
 */
- (CGFloat)ob_heightWithFont:(UIFont *)font width:(CGFloat)width;

@end
