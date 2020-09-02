//
//  KSCrashInstallationDbyServer.m
//  KSCrash
//
//  Created by yxibng on 2020/9/1.
//  Copyright © 2020 Karl Stenerud. All rights reserved.
//

#import "KSCrashInstallationDbyServer.h"
#import "KSCrashReportSinkDbyServer.h"
#import "KSCrashInstallation+Private.h"

@implementation KSCrashInstallationDbyServer

@synthesize url = _url;


+ (instancetype) sharedInstance
{
    static KSCrashInstallationDbyServer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KSCrashInstallationDbyServer alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super initWithRequiredProperties:@[@"url"]];
    if (!self) {
        return nil;
    }
    return self;
}

- (id<KSCrashReportFilter>) sink
{
    KSCrashReportSinkDbyServer* sink = [KSCrashReportSinkDbyServer sinkWithURL:[NSURL URLWithString:self.url]];
    
    return [sink defaultCrashReportFilterSetAppleFmt];
}


@end
