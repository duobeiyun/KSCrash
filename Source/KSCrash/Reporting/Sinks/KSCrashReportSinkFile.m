//
//  KSCrashReportSinkFile.m
//  TestCrash
//
//  Created by zhangjunbo on 14-7-28.
//  Copyright (c) 2014年 ZhangJunbo. All rights reserved.
//

#import "KSCrashReportSinkFile.h"
#import "KSCrashReportFilterAppleFmt.h"
#import "KSCrashReportFilterBasic.h"

@interface KSCrashReportSinkFile ()

@property (nonatomic, readwrite, retain) NSString* fileDir;

@end

@implementation KSCrashReportSinkFile

@synthesize fileDir = _fileDir;


- (void) dealloc
{

}


+ (KSCrashReportSinkFile*) sinkWithFileDir:(NSString *)fileDir
{
    return [[KSCrashReportSinkFile alloc] initWithFileDir:fileDir];
}

- (id) initWithFileDir:(NSString *)fileDir
{
    if((self = [super init])){
        self.fileDir = fileDir;
    }
    return self;
}

- (BOOL) ensureDirectoryExists:(NSString*) path
{
    NSError* error = nil;
    NSFileManager* fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:path]) {
        return YES;
    }
    
    BOOL ret = [fm createDirectoryAtPath:path
             withIntermediateDirectories:YES
                              attributes:nil
                                   error:&error];
    if (!ret) {
        NSLog(@"Could not create directory %@: %@.", path, error);
    }
    
    return ret;
}


- (void) filterReports:(NSArray*) reports
          onCompletion:(KSCrashReportFilterCompletion) onCompletion
{
    [self ensureDirectoryExists:self.fileDir];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    
    for (NSString *crash  in reports) {
        NSString *fileName = [NSString stringWithFormat:@"%@.log",[dateFormatter stringFromDate:[NSDate date]]];
        fileName = [self.fileDir stringByAppendingPathComponent:fileName];
        
        [[NSFileManager defaultManager] createFileAtPath:fileName
                                                contents:nil
                                              attributes:nil];
        
        [crash writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    kscrash_callCompletion(onCompletion, reports, YES, nil);
}


- (id<KSCrashReportFilter>)defaultCrashReportFilterSet {
    return [KSCrashReportFilterPipeline filterWithFilters:
            [KSCrashReportFilterAppleFmt filterWithReportStyle:KSAppleReportStyleSymbolicated],
            self,
            nil];
}

@end
