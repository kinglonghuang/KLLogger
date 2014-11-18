//
//  MttLog.m
//  MttLog
//
//  Created by kinglong huang on 2/21/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import "Logger.h"

#define MaxCountForLogQueue         100

#if  DEBUG
#define LogToTheConsole(xx,...)     NSLog(@"%@",xx,##__VA_ARGS__);
#else
#define LogToTheConsole(xx,...)
#endif

@interface Logger()

@property (nonatomic, strong) NSMutableArray  *logQueue;

@end

@implementation Logger

#pragma mark - LifeCycle

- (id)init {
    self = [super init];
    if (self) {
        self.logLevelForConsole = LogLevelMask_Console;//Log all level for console by default.
        self.logLevelForTrace = LogLevelMask_Trace;
        self.logQueue = [NSMutableArray array];
        self.moduleIDMask = 0;//Log all module by default.
        return self;
    }
    return nil;
}

#pragma mark - Private

- (void)addToQueueWithLog:(NSString *)logString {
    //save to queue
    [self.logQueue addObject:logString];
    //check if reach the maximum count
    if ([self.logQueue count] > MaxCountForLogQueue) {
        NSInteger logCountForRemove = self.logQueue.count - MaxCountForLogQueue;
        for (NSInteger index = 0; index < logCountForRemove; index ++) {
            [self.logQueue removeObjectAtIndex:0];
        }
    }
}

#pragma mark - Public

+ (id)sharedLogger {
    static dispatch_once_t pred = 0;
    __strong static id _sharedLogger = nil;
    dispatch_once(&pred, ^{
        _sharedLogger = [[super alloc] init];
    });
    return _sharedLogger;
}

- (void)addLog:(NSString *)logString logLevel:(LogLevel)level function:(const char *)function line:(NSUInteger)line module:(NSUInteger)moduleID {
    logString = [NSString stringWithFormat:@"%@ (%@) %s: %@",tableForLogLevel[((int)log2((double)level))],tableForLogID[((int)log2((double)moduleID))], function, logString];
    //Check if this kind of log is registered
    if (self.moduleIDMask == 0 || (self.moduleIDMask & moduleID)) {
        if (self.logLevelForConsole & level) {
            //if LogLevel_Debug is registered for console , print it to the Console
            LogToTheConsole(logString);
        }
        
        if (self.logLevelForTrace & level) {
            //if LogLevel_Debug is registered for trace, save it to memory queue
            [self addToQueueWithLog:logString];
        }
    }
}

- (NSArray *)latestLogs {
    return self.logQueue;
}

@end
