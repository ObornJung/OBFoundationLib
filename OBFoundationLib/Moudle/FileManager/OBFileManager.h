//
//  OBFileManager.h
//  ATGFoundationLib
//
//  Created by Oborn.Jung on 14-6-7.
//  Copyright (c) 2014 Oborn.Jung Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBFileManager: NSObject

+ (NSString *)systemResourcePath;

+ (NSString *)systemCachePath;

+ (NSString *)systemTemporaryPath;

+ (NSString *)systemDocumentPath;

/**
 *  APP cache path: systemCachePath/bundleId/
 *
 *  @return APP cache path
 */
+ (NSString *)appCachePath;

/**
 *  App document path: systemDocumentPath/bundleId/
 *
 *  @return App document path
 */
+ (NSString *)appDocumentPath;

/**
 *  App temporary path: systemTemporaryPath/bundleId/
 *
 *  @return App Temporary path
 */
+ (NSString *)appTemporaryPath;

/**
 *  删除给定路径的文件
 *
 *  @param aPath 给定的文件路径
 *
 *  @return 删除是否成功
 */
+ (BOOL)removeFileAtPath:(NSString *)aPath;

@end