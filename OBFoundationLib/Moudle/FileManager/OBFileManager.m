//
//  OBFileManager.m
//  ATGFoundationLib
//
//  Created by ObornJung@gmail.com on 14-6-7.
//  Copyright (c) 2014 ATG Inc. All rights reserved.
//

#import "OBToolsMacro.h"
#import "OBSystemExtend.h"
#import "OBFileManager.h"

@interface OBFileManager()

+ (NSString *)_rootDirName;

+ (BOOL)_fileExistsAtPath:(NSString *)aPath;

+ (BOOL)_createDirectoryAtPathIfNeeded:(NSString *)aPath;

@end

@implementation OBFileManager

#pragma mark - System file path

+ (NSString *)systemResourcePath {

    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)systemTemporaryPath {
    
    return NSTemporaryDirectory();
}

+ (NSString *)systemCachePath {

    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)systemDocumentPath {

    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

#pragma mark - App file path

+ (NSString *)appTemporaryPath {
    static NSString * path = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^ {
                      path = [[self systemTemporaryPath] stringByAppendingPathComponent:[self _rootDirName]];
                      [self _createDirectoryAtPathIfNeeded:path];
                  });
    return path;
}

+ (NSString *)appCachePath {
    static NSString * path = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^ {
                      path = [[self systemCachePath] stringByAppendingPathComponent:[self _rootDirName]];
                      [self _createDirectoryAtPathIfNeeded:path];
                  });
    
    return path;
}

+ (NSString *)appDocumentPath {
    static NSString * path = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^ {
                      path = [[self systemDocumentPath] stringByAppendingPathComponent:[self _rootDirName]];
                      [self _createDirectoryAtPathIfNeeded:path];
                  });
    
    return path;
}

#pragma mark -

+ (BOOL)removeFileAtPath:(NSString *)aPath
{
    BOOL success = YES;
    if ([self _fileExistsAtPath:aPath])
    {
        success = [[NSFileManager defaultManager] removeItemAtPath:aPath error:nil];
    }
    return success;
}

#pragma mark - private methods

+ (NSString *)_rootDirName {
    return [UIApplication ob_bundleId];
}

+ (BOOL)_fileExistsAtPath:(NSString *)aPath {
    return [[NSFileManager defaultManager] fileExistsAtPath:aPath];
}

+ (BOOL)_createDirectoryAtPathIfNeeded:(NSString *)aPath {
    BOOL success = YES;
    if (NO == [self _fileExistsAtPath:aPath]) {
        success = [[NSFileManager defaultManager] createDirectoryAtPath:aPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return success;
}

@end
