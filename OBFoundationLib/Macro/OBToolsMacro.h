//
//  OBToolsMacro.h
//  OBFoundationLib
//
//  Created by Oborn.Jung on 12/4/15.
//  Copyright © 2015 ObornJung. All rights reserved.
//

#ifndef OBToolsMacro_h
#define OBToolsMacro_h

/**
 *    main线程安全运行宏
 */
#ifndef dispatch_main_sync_safe
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_sync(dispatch_get_main_queue(), block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

/**
 *    macro ignored -Wobjc-method-access warning
 */
#define OBSuppressMethodAccessWarning(Stuff) \
do {\
    _Pragma("clang diagnostic push")\
    _Pragma("clang diagnostic ignored\"-Wobjc-method-access\"")\
    Stuff;\
    _Pragma("clang diagnostic pop") \
} while(0)

/**
 *    系统版本判断宏
 */
#define OBSYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define OBSYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define OBSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define OBSYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define OBSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 *    浮点数相等判断
 */
#define OBFLOAT_EQUAL(a, b) (fabs((a)-(b)) < FLT_EPSILON)

#endif /* OBToolsMacro_h */
