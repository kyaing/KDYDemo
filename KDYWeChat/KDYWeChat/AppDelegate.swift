//
//  AppDelegate.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 加载Main
        //startMainStory()
        
        
        
        return true
    }
    
    func startTabBar() {
        window?.frame = UIScreen.mainScreen().bounds
        window?.backgroundColor = UIColor.whiteColor()
        
        let rootController = KDTabBarController()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}

