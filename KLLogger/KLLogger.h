//
//  KLLogger.h
//  TestMttLogger
//
//  Created by kinglong huang on 11/14/14.
/*
 * https://github.com/kinglonghuang/KLLogger
 *
 * BSD license follows (http://www.opensource.org/licenses/bsd-license.php)
 *
 * Copyright (c) 2013 KLStudio.(kinglong.huang) All Rights Reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of  source code  must retain  the above  copyright notice,
 * this list of  conditions and the following  disclaimer. Redistributions in
 * binary  form must  reproduce  the  above copyright  notice,  this list  of
 * conditions and the following disclaimer  in the documentation and/or other
 * materials  provided with  the distribution.  Neither the  name of  Wei
 * Wang nor the names of its contributors may be used to endorse or promote
 * products  derived  from  this  software  without  specific  prior  written
 * permission.  THIS  SOFTWARE  IS  PROVIDED BY  THE  COPYRIGHT  HOLDERS  AND
 * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A  PARTICULAR PURPOSE  ARE DISCLAIMED.  IN  NO EVENT  SHALL THE  COPYRIGHT
 * HOLDER OR  CONTRIBUTORS BE  LIABLE FOR  ANY DIRECT,  INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY,  OR CONSEQUENTIAL DAMAGES (INCLUDING,  BUT NOT LIMITED
 * TO, PROCUREMENT  OF SUBSTITUTE GOODS  OR SERVICES;  LOSS OF USE,  DATA, OR
 * PROFITS; OR  BUSINESS INTERRUPTION)  HOWEVER CAUSED AND  ON ANY  THEORY OF
 * LIABILITY,  WHETHER  IN CONTRACT,  STRICT  LIABILITY,  OR TORT  (INCLUDING
 * NEGLIGENCE  OR OTHERWISE)  ARISING  IN ANY  WAY  OUT OF  THE  USE OF  THIS
 * SOFTWARE,   EVEN  IF   ADVISED  OF   THE  POSSIBILITY   OF  SUCH   DAMAGE.
 *
 */

#import "Logger.h"

@interface KLLogger : Logger

+ (id)sharedLogger;
//Console log only display on the console, won't be upload to RDM, this is a custom method.
- (void)registerLogLevelForConsole:(LogLevel)logLevelMask;
//Trace log should be upload to RDM, this is a custom method.
- (void)registerLogLevelForTrace:(LogLevel)logLevelMask;
//Only registered logID can display on the console
- (void)registerLoggerWithModuleID:(ModuleID)moduleIDMask;

@end

#define KLLog_Debug(ModuleID, Format,...)           Log_Debug(KLLogger, ModuleID, Format, ##__VA_ARGS__)
#define KLLog_Info(ModuleID, Format,...)            Log_Info(KLLogger, ModuleID, Format, ##__VA_ARGS__)
#define KLLog_Warning(ModuleID, Format,...)         Log_Warning(KLLogger, ModuleID , Format, ##__VA_ARGS__)
#define KLLog_Error(ModuleID, Format,...)           Log_Error(KLLogger, ModuleID, Format, ##__VA_ARGS__)