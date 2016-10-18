//
//  OBLogFile.m
//  OBFoundationLib
//
//  Created by ObornJung@gmail.com on 8/13/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import "OBMacro.h"
#import "OBLogFile.h"
#import "OBFileManager.h"
#import "OBSystemExtend.h"

@interface OBLogFile()

@property (nonatomic, strong) NSOutputStream    * logStream;
@property (nonatomic, strong) NSThread          * logThread;
@property (nonatomic, strong) NSDateFormatter   * dateFormatter;

- (void)logThreadProcess;

@end

@implementation OBLogFile

#pragma mark - life cycle
+ (instancetype)defaultLogFile
{
    static OBLogFile * defaultLogFile = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        defaultLogFile = [[[self class] alloc] initWithPath:nil fileName:nil];
    });
    return defaultLogFile;
}

+ (void)printUMUDID {
    Class cls = NSClassFromString(@"UMANUtil");
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
#pragma clang diagnostic pop
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
    options:NSJSONWritingPrettyPrinted
    error:nil];

    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

+ (instancetype)errorLogFile
{
    static OBLogFile * errorLogFile = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        errorLogFile = [[[self class] alloc] initWithPath:nil fileName:@"OBErrorLog.log"];
    });
    return errorLogFile;
}

- (instancetype)initWithPath:(NSString *)aPath fileName:(NSString *)aFileName
{
    self = [super init];
    if (self)
    {
        if (nil == aPath)
        {
            aPath = [[OBFileManager appCachePath] stringByAppendingPathComponent:@"log"];
        }
        NSError * error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:aPath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:aPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
        }

        if (nil == error)
        {
            if (nil ==  aFileName)
            {
                NSString * dateString = [self.dateFormatter stringFromDate:[NSDate date]];
                aFileName = [NSString stringWithFormat:@"/%@.log", dateString];
            }
            aPath = [aPath stringByAppendingPathComponent:aFileName];
            self.logStream = [NSOutputStream outputStreamToFileAtPath:aPath append:YES];
            [self.logStream open];
            self.logThread = [[NSThread alloc] initWithTarget:self selector:@selector(logThreadProcess) object:nil];
            self.logThread.name = aFileName;
            [self.logThread setThreadPriority:0];
            [self.logThread start];
        }
    }
    return self;
}

- (void)dealloc
{
    if (self.logStream)
    {
        [self.logStream close];
        self.logStream = nil;
    }
    
    if (self.logThread)
    {
        [self.logThread cancel];
        self.logThread = nil;
    }
}

#pragma mark - getter & setter
- (NSDateFormatter *)dateFormatter
{
    if (nil == _dateFormatter)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    }
    return _dateFormatter;
}

#pragma mark - public methods
- (void)write:(NSString *)aFormat, ...
{
    va_list args;
    va_start(args, aFormat);
    NSString * formatString = [[NSString alloc] initWithFormat:aFormat arguments:args];
    NSString * dateString = [self.dateFormatter stringFromDate:[NSDate date]];
    NSString * logString = [NSString stringWithFormat:@"%@ %@\n", dateString, formatString];
    [self performSelector:@selector(printLog:) onThread:self.logThread withObject:logString waitUntilDone:NO];
    va_end(args);
}

#pragma mark - private methods
- (void)logThreadProcess
{
    @autoreleasepool
    {
        while (![self.logThread isCancelled])
        {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        }
    }
}

- (void)printLog:(NSString *)aLog
{
    NSInteger logLength = [aLog lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSInteger writeLength = [self.logStream write:(uint8_t *)(aLog.UTF8String) maxLength:logLength];
    if (-1 == writeLength)
    {
        OBLog(@"write log %p failed!error info:%@", aLog, self.logStream.streamError);
    }
    else if (writeLength != logLength)
    {
        OBLog(@"write log %p losted:%ld byte!error info:%@", aLog, (long)logLength - writeLength, self.logStream.streamError);
    }
}

@end
