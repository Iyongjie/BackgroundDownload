//
//  DownloadManager.h
//  BackgroundDownload
//
//  Created by 李永杰 on 2019/6/12.
//  Copyright © 2019 liyongjie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OnProgress)(float );

@interface DownloadManager : NSObject<NSURLSessionDelegate,NSURLSessionDownloadDelegate>

@property (nonatomic, copy)     OnProgress      onProgress;

@property (nonatomic, strong)   NSURLSession    *session;

+(instancetype)shared;

@end

