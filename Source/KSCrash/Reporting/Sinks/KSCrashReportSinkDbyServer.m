//
//  KSCrashReportSinkDbyServer.m
//  KSCrash
//
//  Created by yxibng on 2020/9/1.
//  Copyright © 2020 Karl Stenerud. All rights reserved.
//

#import "KSCrashReportSinkDbyServer.h"
#import "KSCrashReportFilterAppleFmt.h"
#import "KSCrashReportFilterBasic.h"
#import "KSCrashReportFilterGZip.h"


@interface KSCrashReportSinkDbyServer ()

@property (nonatomic, copy) NSURL *URL;

@end


@implementation KSCrashReportSinkDbyServer
@synthesize URL = _URL;

+ (KSCrashReportSinkDbyServer *)sinkWithURL:(NSURL *)URL {
    
    KSCrashReportSinkDbyServer *sink = [[KSCrashReportSinkDbyServer alloc] init];
    sink.URL = URL;
    return sink;
}

- (void) filterReports:(NSArray*) reports
          onCompletion:(KSCrashReportFilterCompletion) onCompletion
{
    //开始上传文件
    NSDictionary *params = @{@"type":@"custom",
                             @"info":@{
                                     @"crash":reports
                             }
    };
    
    NSError *tojson_error;
    NSData *crash_data = [NSJSONSerialization dataWithJSONObject:params options:0 error:&tojson_error];
    if (tojson_error) {
        kscrash_callCompletion(onCompletion, reports, NO, tojson_error);
    }
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.URL];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = crash_data;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        if (res.statusCode == 204) {
            kscrash_callCompletion(onCompletion, reports, YES, nil);
        } else {
            kscrash_callCompletion(onCompletion, reports, NO, error);
        }
    }];
    [task resume];
}



- (id)defaultCrashReportFilterSetAppleFmt {
    return [KSCrashReportFilterPipeline filterWithFilters:
            [KSCrashReportFilterAppleFmt filterWithReportStyle:KSAppleReportStyleSymbolicated],
            self,
            nil];
}

@end
