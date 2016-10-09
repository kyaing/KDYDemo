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
        EMClient.sharedClient().applicationDidEnterBackground(application)
    }
    
    // App将要进入前台
    func applicationWillEnterForeground(application: UIApplication) {
        EMClient.sharedClient().applicationWillEnterForeground(application)
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
        
        let apnsCerName: String
        #if DEBUG
            apnsCerName = emApnsDevCerName
        #else
            apnsCerName = emApnsProCerName
        #endif
        
        self.easemobApplication(application,
                                launchOptions: launchOptions,
                                appKey: emAppKey,
                                apnsCerName: apnsCerName,
                                otherConfig: nil)
        
        // 登录环信
        loginEmSDK(emUserName, password: emPassword)
    }
    
    func setupLeanCloud() {
        LeanCloud.initialize(applicationID: leanCloudAppId, applicationKey: leanCloudAppKey)
        
        // for test
        let post = LCObject(className: "TestObject")
        post.set("word", object: "hello world!")
        post.save()
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

