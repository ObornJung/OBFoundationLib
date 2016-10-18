//
//  NSString+OBExtend.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 8/20/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSString+OBExtend.h"

@implementation NSString (OBExtend)

- (NSString *)ob_md5 {
    const char * cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest); // This is the md5 call
    
    NSMutableString * md5Str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5Str appendFormat:@"%02x", digest[i]];
    }
    
    return  md5Str;
}

+ (NSString *)ob_phoneNumberRegularization:(NSString *)phoneNumber {
    
    NSString * result = phoneNumber;
    result = [result stringByReplacingOccurrencesOfString:@"<" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@">" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"+" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    return  result;
}

- (CGFloat)ob_heightWithFont:(UIFont *)font width:(CGFloat)width {
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, 0)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size.height;
    return (height + 2.0f);
}

@end
