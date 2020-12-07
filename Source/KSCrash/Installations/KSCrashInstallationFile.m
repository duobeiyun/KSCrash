//
//  KSCrashInstallationFile.m
//  TestCrash
//
//  Created by zhangjunbo on 14-7-28.
//  Copyright (c) 2014年 ZhangJunbo. All rights reserved.
//

#import "KSCrashInstallationFile.h"
#import "KSCrashInstallation+Private.h"
#import "KSCrashReportSinkFile.h"

@implementation KSCrashInstallationFile

@synthesize fileDir = _fileDir;

- (void) dealloc
{
    
}

+ (instancetype) sharedInstance
{
    static KSCrashInstallationFile *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KSCrashInstallationFile alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super initWithRequiredProperties:@[@"fileDir"]];
    if (!self) {
        return nil;
    }
    return self;
}



- (id<KSCrashReportFilter>) sink
{
    KSCrashReportSinkFile* sink = [KSCrashReportSinkFile sinkWithFileDir:self.fileDir];
    return [sink defaultCrashReportFilterSet];
}



@end
