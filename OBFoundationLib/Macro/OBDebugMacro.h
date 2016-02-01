//
//  OBDebugMacro.h
//  OBFoundationLib
//
//  Created by ObornJung@gmail.com on 8/20/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#ifndef OBFoundationLib_OBDebugMacro_h
#define OBFoundationLib_OBDebugMacro_h

#import <Foundation/Foundation.h>

#undef OBLog
#if DEBUG
#define OBLog(fmt, ...) NSLog((@"%s [Line %d] --By ObornJung--" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define OBLog(...)
#endif

#undef OBSLog
#if DEBUG
#define OBSLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#define OBSLog(...)
#endif

#undef OBPrintSeparator
#if DEBUG
#define OBPrintSeparator(title) OBSLog(@"|||||||||||||||||||||||||%@|||||||||||||||||||||||||", (title)?:@"")
#else
#define OBSLog(...)
#endif

#undef OBAssert
#if DEBUG
#define OBAssert(condition, desc, ...)  NSAssert(condition, desc, ##__VA_ARGS__)
#else
#define OBAssert(condition, desc, ...) do {\
    if (!condition) {\
        [[OBLogFile errorLogFile] write:desc, ##__VA_ARGS__];\
    }\
}while(0)
#endif

#undef OBParameterAssert
#if DEBUG
#define OBParameterAssert(condition)    NSParameterAssert(condition)
#else
#define OBParameterAssert(condition)    do {\
    if (!condition) {\
        [[OBLogFile errorLogFile] write:#condition];\
    }\
}while(0)
#endif

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

#endif /* OBFoundationLib_OBDebugMacro_h */

