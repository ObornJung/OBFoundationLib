//
//  NSObject+OBExtend.h
//  OBFoundationLib
//
//  Created by Oborn.Jung on 12/1/15.
//  Copyright © 2015 ObornJung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OBExtend)
/**
 *  swizzle两个方法调用
 *
 *  @param selector1 需要交换的方法1
 *  @param selector2 需要交换的方法2
 *
 *  @return 是否成功
 */
+ (BOOL)ob_swizzleMethod:(SEL)selector1 withMethod:(SEL)selector2;

@end
