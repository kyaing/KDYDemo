//
//  AppDelegate+LeanCloud.swift
//  KDYWeChat
//
//  Created by mac on 16/9/30.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation
import LeanCloud

extension AppDelegate {
    
    /**
     *  初始化 LeanClound
     */
    func leanCloundApplication(application: UIApplication, launchOptions: [NSObject: AnyObject]?) {
        LeanCloud.initialize(applicationID: leanCloudAppId, applicationKey: leanCloudAppKey)
    }
    
    func initLeanClound() {
        
    }
    
    func clearLeanClound() {
        
    }
}

