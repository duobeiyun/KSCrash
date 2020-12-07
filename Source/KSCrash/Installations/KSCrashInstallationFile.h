//
//  KSCrashInstallationFile.h
//  TestCrash
//
//  Created by zhangjunbo on 14-7-28.
//  Copyright (c) 2014年 ZhangJunbo. All rights reserved.
//

#import "KSCrashInstallation.h"

@interface KSCrashInstallationFile : KSCrashInstallation

@property(nonatomic, copy) NSString* fileDir;

+ (instancetype)sharedInstance;

@end
