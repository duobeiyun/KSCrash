//
//  KSCrashInstallationDbyServer.h
//  KSCrash
//
//  Created by yxibng on 2020/9/1.
//  Copyright © 2020 Karl Stenerud. All rights reserved.
//

#import "KSCrashInstallation.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSCrashInstallationDbyServer : KSCrashInstallation
+ (instancetype) sharedInstance;
@property (nonatomic, copy) NSString *url;


@end

NS_ASSUME_NONNULL_END
