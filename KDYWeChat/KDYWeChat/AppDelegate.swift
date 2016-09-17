//
//  AppDelegate.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

// 环信配置参数
let emAppKey         = "kdy#kdywechat"
let emClinetId       = "YXA6Y7mEEHfkEeaj5e2MKO4LDw"
let emClientSecret   = "YXA6s_ZXqJD7UKFkvubKfv1_9BXDIKI"
let emApnsDevCerName = "kdychat_devleop"

let emUserName       = "kdy"
let emPassword       = "121307"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabbarController: KDTabBarController?

    // MARK: - AppDelegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 设置根视图
        setupRootController()
        
        // 配置环信
        setupEmSDK()
        
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
    
    func setupEmSDK() {
        // 注册的 AppKey，和推送证书名
        let options = EMOptions(appkey: emAppKey)
        options.apnsCertName = emApnsDevCerName
        
        EMClient.sharedClient().initializeSDKWithOptions(options)
        
        // 登录环信
        loginEmSDK(emUserName, password: emPassword)
    }
    
    func loginEmSDK(userName: NSString, password: NSString) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                let error = EMClient.sharedClient().loginWithUsername(emUserName, password: emPassword)
                if error == nil {
                    // 设置自动登录
                    EMClient.sharedClient().options.isAutoLogin = true
                } else {
                    print(">>环信登录成功<<")
                }
            }
        }
    }
}

