//
//  AppDelegate.m
//  KDYDemo
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "AppDelegate.h"
#import "KDViewController.h"

#define kAppKey             @"985654585"
#define kAppSecret          @"581f0e6e9a812c13a67e3b404c98b678"
#define kAppRedirectURI     @"http://www.itheima.com"

@interface AppDelegate () 

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //KDViewController作为根控制器
    ZYNavigationController *navi = [[ZYNavigationController alloc] initWithRootViewController:[KDViewController new]];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    //初始化微博SDK
    self.mainVC = [KDWeiboMainViewController new];
    [self initSinaWeibo];
    
    //注册推送
    if (KiOSVersion > 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        //        UIRemoteNotificationType myTpes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTpes];
    }
    
    return YES;
}

/**
 *  接收本地推送通知
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //当App处于激活状态，接收本地消息
    if (application.applicationState == UIApplicationStateActive) {
        
    }
}

- (void)initSinaWeibo {
    //这里复制了SDK中的代码，用以初始化微博对象
    self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey
                                             appSecret:kAppSecret
                                        appRedirectURI:kAppRedirectURI
                                           andDelegate:(id)self.mainVC];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"]) {
        self.sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        self.sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        self.sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}

@end

