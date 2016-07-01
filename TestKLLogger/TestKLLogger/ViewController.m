//
//  ViewController.m
//  TestKLLogger
//
//  Created by kinglong huang on 11/17/14.
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

#import "ViewController.h"
#import "KLLogger.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Test

- (void)test {
    LogDebug(ModuleID_Common, @"This is a debug log from %@",@"Common");
    LogInfo(ModuleID_Download, @"This is a info log from %@", @"Download");
    LogError(ModuleID_Common, @"This is error log from %@",@"Common");
    LogDebug(ModuleID_Download, @"This is another debug log from %@",@"Download");
    
    //Customize log define
#define DownloadLog(Format,...)     Log_Debug(ModuleID_Download, Format, ##__VA_ARGS__)
#define VideoLog(Format,...)        Log_Info(ModuleID_Video, Format, ##__VA_ARGS__)
    
    //Customize log demo.
    DownloadLog(@"this is a debug log for download module");
    VideoLog(@"This is a info log for video module"); //will not show, because the video module has not been registered.
}

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Custom Configuration
    [[KLLogger sharedLogger] registerLogLevelForConsole:LogLevel_Debug|LogLevel_Info];
    [[KLLogger sharedLogger] registerLogLevelForTrace:LogLevel_Error];
    [[KLLogger sharedLogger] registerLoggerWithModuleID:ModuleID_Common|ModuleID_Download];
    
    [self test];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
