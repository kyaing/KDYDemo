//
//  AppDelegate.h
//  KDYDemo
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "KDWeiboMainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) KDWeiboMainViewController *mainVC;
@property (strong, nonatomic) SinaWeibo *sinaweibo;

@end

