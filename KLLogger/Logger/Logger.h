//
//  Logger.h
//  MttHD
//
//  Created by kinglong huang on 2/21/14.
//  Copyright (c) 2014 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLLoggerDefine.h"

typedef NS_ENUM(NSInteger, LogLevel) {
	LogLevel_Debug      = 1 << 0,
    LogLevel_Info       = 1 << 1,
	LogLevel_Warning    = 1 << 2,
	LogLevel_Error      = 1 << 3,
    LogLevel_MaskAll        = LogLevel_Debug|LogLevel_Info|LogLevel_Warning|LogLevel_Error
};

typedef NS_ENUM(NSInteger, LogLevelMask) {
    LogLevelMask_Console    = LogLevel_Debug|LogLevel_Info|LogLevel_Warning|LogLevel_Error,
    LogLevelMask_Trace      = LogLevel_Warning|LogLevel_Error,
    LogLevelMask_All        = LogLevel_Debug|LogLevel_Info|LogLevel_Warning|LogLevel_Error
};

static NSString * tableForLogLevel[] = {
    @"Debug",
    @"Info",
    @"Warning",
    @"Error",
};

@interface Logger : NSObject

@property (nonatomic, assign) LogLevel logLevelForConsole;
@property (nonatomic, assign) LogLevel logLevelForTrace;
@property (nonatomic, assign) NSInteger moduleIDMask;

+ (id)sharedLogger;

- (void)addLog:(NSString *)logString logLevel:(LogLevel)level function:(const char *)function line:(NSUInteger)line module:(NSUInteger)moduleID;

- (NSArray *)latestLogs;

@end

#define Log_Debug(ALogger, ModuleID, Format, ...) [[ALogger sharedLogger] addLog:[NSString stringWithFormat:(Format),##__VA_ARGS__] logLevel:(LogLevel_Debug) function:__PRETTY_FUNCTION__ line:__LINE__ module:ModuleID];

#define Log_Info(ALogger, ModuleID, Format, ...) [[ALogger sharedLogger] addLog:[NSString stringWithFormat:(Format),##__VA_ARGS__] logLevel:(LogLevel_Info) function:__FUNCTION__ line:__LINE__ module:ModuleID];

#define Log_Warning(ALogger, ModuleID, Format, ...) [[ALogger sharedLogger] addLog:[NSString stringWithFormat:(Format),##__VA_ARGS__] logLevel:(LogLevel_Warning) function:__PRETTY_FUNCTION__ line:__LINE__ module:ModuleID];

#define Log_Error(ALogger, ModuleID, Format, ...) [[ALogger sharedLogger] addLog:[NSString stringWithFormat:(Format),##__VA_ARGS__] logLevel:(LogLevel_Error) function:__PRETTY_FUNCTION__ line:__LINE__ module:ModuleID];

