//
//  TTBaseModel.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 1/1/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

#import "TTBaseModel.h"
#include <objc/runtime.h>

typedef id (*TTModelGetterFunction)(id, SEL);

@interface TTBaseModel ()

@property (nonatomic, strong) NSDictionary  * data;

@end

@implementation TTBaseModel

+ (NSMutableDictionary *)methodMap {
    static dispatch_once_t onceToken;
    static NSMutableDictionary * sTradeMethodMap = nil;
    dispatch_once(&onceToken, ^{
        sTradeMethodMap = [NSMutableDictionary dictionary];
    });
    return sTradeMethodMap;
}

+ (void)initialize
{
    unsigned int count = 0;
    objc_property_t * propertyList = class_copyPropertyList([self class], &count);
    NSString * className = NSStringFromClass([self class]);
    [self methodMap][className] = [NSMutableDictionary dictionaryWithCapacity:count];
    
    IMP universalGetterIMP = class_getMethodImplementation([self class], @selector(universalGetter));
    for (int i = 0; i < count; i ++) {
        const char * propertyName = property_getName(propertyList[i]);
        NSString * getterSelectorString = [NSString stringWithCString:propertyName
                                                             encoding:NSUTF8StringEncoding];
        Method getterMethod = class_getInstanceMethod([self class], NSSelectorFromString(getterSelectorString));
        
        IMP oriMethod = class_replaceMethod([self class],
                                            method_getName(getterMethod),
                                            universalGetterIMP,
                                            method_getTypeEncoding(getterMethod));
        if (method_getTypeEncoding(getterMethod)[0] == '@') {
            [self methodMap][className][getterSelectorString] = [NSNumber numberWithLong:(long)oriMethod];
        }
    }
    free(propertyList);
}

- (id)initWithData:(NSMutableDictionary *)data {
    self = [super init];
    if (self) {
        _data = data;
    }
    return self;
}

- (void)reload:(NSMutableDictionary *)data {
    _data = data;
}

- (id)universalGetter {
    id result = nil;
    NSString * selectorName = NSStringFromSelector(_cmd);
    Class selectorClass = [self class];
    while (selectorClass) {
        NSString * className = NSStringFromClass(selectorClass);
        TTModelGetterFunction oriMethod = (TTModelGetterFunction)([[[self class] methodMap][className][selectorName] longValue]);
        if (oriMethod) {
            result = oriMethod(self, _cmd) ?: _data[selectorName];
            break;
        }
        selectorClass = [selectorClass superclass];
    }
    return result;
}

@end
