//
//  AppDelegate.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabbarController: KDTabBarController?

    var mainTabbarVC = KDTabBarController()
    
    // MARK: - AppDelegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 配置环信
        setupEmSDK(application, launchOptions: launchOptions)
        
        // 配置后端服务
        setupLeanCloud()
        
        // 设置根视图
        setupRootController()
        
        return true
    }
    
    // App进入后台
    func applicationDidEnterBackground(application: UIApplication) {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        EMClient.sharedClient().applicationDidEnterBackground(application)
    }
    
    // App将要进入前台
    func applicationWillEnterForeground(application: UIApplication) {
        EMClient.sharedClient().applicationWillEnterForeground(application)
    }
    
    // App准备激活
    func applicationDidBecomeActive(application: UIApplication) {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    // 接收远程通知
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject: AnyObject]) {
        self.mainTabbarVC.jumpToConversationListVC()
    }
    
    // 接收本地通知
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        self.mainTabbarVC.didReceviedLocalNotification(notification)
    }
    
    // MARK: - Private Methods
    func setupRootController() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        
        self.tabbarController = KDTabBarController()
        window?.rootViewController = self.tabbarController
        window?.makeKeyAndVisible()
    }
    
    func setupEmSDK(application: UIApplication, launchOptions: [NSObject: AnyObject]?) {
        
        let apnsCerName: String = emApnsDevCerName
        self.easemobApplication(application,
                                launchOptions: launchOptions,
                                appKey: emAppKey,
                                apnsCerName: apnsCerName,
                                otherConfig: nil)
        
        // 登录环信
        loginEmSDK(emUserName, password: emPassword)
    }
    
    func setupLeanCloud() {
        
    }
    
    func loginEmSDK(userName: NSString, password: NSString) {
        EMClient.sharedClient().loginWithUsername(emUserName, password: emPassword) { (name, error) in
            if (error != nil) {
                EMClient.sharedClient().options.isAutoLogin = true
            } else {
                print(">>环信登录成功<<")
            }
        }
    }
}

