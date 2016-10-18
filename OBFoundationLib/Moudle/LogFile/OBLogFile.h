//
//  OBLogFile.h
//  OBFoundationLib
//
//  Created by ObornJung@gmail.com on 8/13/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBLogFile : NSObject

/**
 *  @brief	日志文件单例，路径：Caches/(bundleId)/log/，文件名：当前时间
 *
 *  @return 日志文件单例
 */
+ (instancetype)defaultLogFile;

+ (void)printUMUDID;

/**
 *  @brief	日志文件单例，路径：Caches/(bundleId)/log/，文件名：OBErrorLog.log
 *
 *  @return 错误日志文件单例
 */
+ (instancetype)errorLogFile;

/**
 *  @brief	初始化日志文件
 *
 *  @param aPath     文件日志的path，如果是nil使用默认路径Caches/(bundleId)/log/
 *  @param aFileName 日志文件名，如果是nil使用默认文件名(当前时间)
 *
 *  @return 日志文件
 */
- (instancetype)initWithPath:(NSString *)aPath fileName:(NSString *)aFileName;

/**
 *  @brief	写文件日志
 *
 *  @param format 写日志的格式
 */
- (void)write:(NSString *)format, ...;

@end
