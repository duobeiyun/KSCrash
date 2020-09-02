//
//  KSCrashReportSinkDbyServer.h
//  KSCrash
//
//  Created by yxibng on 2020/9/1.
//  Copyright © 2020 Karl Stenerud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCrashReportFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSCrashReportSinkDbyServer : NSObject <KSCrashReportFilter>

+ (KSCrashReportSinkDbyServer *)sinkWithURL:(NSURL *)URL;

- (id <KSCrashReportFilter>) defaultCrashReportFilterSetAppleFmt;

@end

NS_ASSUME_NONNULL_END
