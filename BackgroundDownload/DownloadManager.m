//
//  DownloadManager.m
//  BackgroundDownload
//
//  Created by 李永杰 on 2019/6/12.
//  Copyright © 2019 liyongjie. All rights reserved.
//

#import "DownloadManager.h"
#import "AppDelegate.h"

@implementation DownloadManager

// 单例
+(instancetype)shared {
    static DownloadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(manager == nil) {
            manager = [[self alloc] init];
        }
     });
    return manager;
}

#pragma mark NSURLSessionDownloadDelegate
// 下载结束
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"下载完成,开始保存");
    if (self.onProgress) {
        self.onProgress(1);
    }
    NSString    *locationPath = location.path;
    NSString    *fileName     = [self getNowTimeTimestamp];
    NSString    *documents    = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtPath:locationPath toPath:[NSString stringWithFormat:@"%@/%@.tmp",documents,fileName] error:nil];
    NSLog(@"%@",documents);
}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 获取进度
    float written  = totalBytesWritten;
    float total    = totalBytesExpectedToWrite;
    float progress = written / total;
    if (self.onProgress) {
        self.onProgress(progress);
    }
}
#pragma mark NSURLSessionDelegate
// 后台下载完，可以安全的挂起了
-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
        if (delegate.callBack) {
            delegate.callBack();
            delegate.callBack = nil;
        }
    });
}
#pragma mark get
-(NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"background-session"];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}
-(NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}
@end
