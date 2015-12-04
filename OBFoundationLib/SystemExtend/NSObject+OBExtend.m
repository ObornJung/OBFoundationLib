//
//  NSObject+FFUtility.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 12/1/15.
//  Copyright © 2015 ObornJung. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+OBExtend.h"

@implementation NSObject (OBExtend)

+ (BOOL)ob_swizzleMethod:(SEL)selector1 withMethod:(SEL)selector2 {
    
    Method method1 = class_getInstanceMethod(self, selector1);
    if (!method1) {
        return NO;
    }
    
    Method method2 = class_getInstanceMethod(self, selector2);
    if (!method2) {
        return NO;
    }
    
    class_addMethod(self,
                    selector1,
                    class_getMethodImplementation(self, selector1),
                    method_getTypeEncoding(method1));
    class_addMethod(self,
                    selector2,
                    class_getMethodImplementation(self, selector2),
                    method_getTypeEncoding(method2));
    
    method_exchangeImplementations(class_getInstanceMethod(self, selector1),
                                   class_getInstanceMethod(self, selector2));
    return YES;
}

@end
