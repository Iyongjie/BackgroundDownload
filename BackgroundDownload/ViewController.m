//
//  ViewController.m
//  BackgroundDownload
//
//  Created by 李永杰 on 2019/6/12.
//  Copyright © 2019 liyongjie. All rights reserved.
//

#import "ViewController.h"
#import "DownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开始下载" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, self.view.bounds.size.width - 200, 50);
    [button addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)download {
    NSURL *url = [NSURL URLWithString:@"https://dldir1.qq.com/dlomg/qqcom/mini/QQNewsMini5.exe"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [[DownloadManager shared].session downloadTaskWithRequest:request];
    [task resume];
    
    
    DownloadManager.shared.onProgress = ^(float progress) {
        NSLog(@"%f",progress);
    };
}

@end
