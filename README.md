KLLogger
========
###一.简介
KLLogger是一个iOS的日志组件，除了提供日志输出功能外，也提供两种维度的日志筛选：<br>
1.基于业务模块的筛选，控制台将只显示注册了的模块（ModuleID）的日志<br>
2.基于日志级别的筛选，控制台将只显示特定日志级别（LogLevel）的日志

用户可选择以下宏来输出日志:

    LogDebug(ModuleID,Format,...)
    LogInfo(ModuleID,Format,...)
    LogWarning(ModuleID,Format,...)
    LogError(ModuleID,Format,...)


###二.自定义

1.在KLLoggerDefine.h中配置所有的业务模块，确保枚举和字符串元素顺序对应。

2.选择需要关注的业务模块，注册对应模块ID（不注册控制台默认输出所有模块的日志）。

    - (void)registerLoggerWithModuleID:(ModuleID)moduleIDMask;

3.注册不同场景的日志级别（不注册将采用默认配置）。

    - (void)registerLogLevelForConsole:(LogLevel)logLevelMask;
    (a)控制台场景，该场景下注册的日志将输出到控制台，不保存到日志队列中
    
    - (void)registerLogLevelForTrace:(LogLevel)logLevelMask;
    (b)追踪场景，该场景下注册的日志不会在控制台显示，只保存到内存中的日志队列，可作为辅助信息上报

 > 默认配置: <br>
   > 控制台场景(a)下注册了所有日志级别 <br>
   > 追踪场景(b)下注册了LogLevel_Warning, LogLevel_Error,两种级别的日志将保存到内存中的日志队列

4.自定义宏，方便模块使用

    #define DownloadLog(Format,...)     Log_Debug(ModuleID_Download, Format, ##__VA_ARGS__)
    #define VideoLog(Format,...)        Log_Info(ModuleID_Video, Format, ##__VA_ARGS__)
    
    DownloadLog(@"This is a debug log for download module");

###三.举例：

    //Custom Configuration
    [[KLLogger sharedLogger] registerLogLevelForConsole:LogLevel_Debug|LogLevel_Info];
    [[KLLogger sharedLogger] registerLogLevelForTrace:LogLevel_Error];
    [[KLLogger sharedLogger] registerLoggerWithModuleID:ModuleID_Common|ModuleID_Download];


    //测试代码
    LogDebug(ModuleID_Common, @"This is a debug log from %@",@"Common");
    LogInfo(ModuleID_Download, @"This is a info log from %@", @"Download");
    LogError(ModuleID_Common, @"This is error log from %@",@"Common");
    LogDebug(ModuleID_Download, @"This is another debug log from %@",@"Download");
    DownloadLog(@"This is a debug log for download module");
    VideoLog(@"This is a info log for video module");
    
控制台显示如下：

    2016-07-01 15:25:01.775 TestKLLogger[11999:2221573] Debug (Common) -[ViewController test]: This is a debug log from Common
    2016-07-01 15:25:01.776 TestKLLogger[11999:2221573] Info (Download) -[ViewController test]: This is a info log from Download
    2016-07-01 15:25:01.776 TestKLLogger[11999:2221573] Debug (Download) -[ViewController test]: This is another debug log from Download
    2016-07-01 15:25:01.776 TestKLLogger[11999:2221573] Debug (Download) -[ViewController test]: This is a debug log for download module
