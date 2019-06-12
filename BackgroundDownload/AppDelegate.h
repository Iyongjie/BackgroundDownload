//
//  AppDelegate.h
//  BackgroundDownload
//
//  Created by 李永杰 on 2019/6/12.
//  Copyright © 2019 liyongjie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DownloadManager.h"
// 后台回调，用来挂起时销毁回调
typedef void(^BackgroundCallback)();

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, copy) BackgroundCallback  callBack;

@property (strong, nonatomic) UIWindow *window;


@end

