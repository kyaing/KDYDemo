//
//  AppDelegate+EaseSDK.swift
//  KDYWeChat
//
//  Created by mac on 16/9/30.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    /**
     *  配置环信sdk
     */
    func easemobApplication(application: UIApplication,
                            launchOptions: [NSObject: AnyObject]?,
                            appKey: String,
                            apnsCerName: String,
                            otherConfig: [NSObject: AnyObject]?) {
        
        EaseSDKHelper.shareInstance.hyphenateApplication(application,
                                                         launchOptions: launchOptions,
                                                         appkey: appKey,
                                                         apnsCerName: apnsCerName,
                                                         otherConfig: nil)
    }
}

