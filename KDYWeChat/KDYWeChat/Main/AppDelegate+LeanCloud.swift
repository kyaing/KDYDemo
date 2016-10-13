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
     *  (因环信不会维护用户体系，所以采用LeanClound服务，来管理用户系统；以后有可能再加入其它功能)
     */
    func leanCloundApplication(application: UIApplication, launchOptions: [NSObject: AnyObject]?) {
        LeanCloud.initialize(applicationID: leanCloudAppId, applicationKey: leanCloudAppKey)
        
        // for test
        let post = LCObject(className: "TestObject")
        post.set("word", object: "hello world!")
        post.save()
        
        if let currentUser = LCUser.current {
            let email    = currentUser.email     // 当前用户的邮箱
            let username = currentUser.username  // 当前用户名
            print("email = \(email), username = \(username)")
        }
    }
    
    func initLeanClound() {
        
    }
    
    func clearLeanClound() {
        
    }
}

