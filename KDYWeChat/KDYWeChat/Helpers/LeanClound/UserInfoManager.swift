//
//  UserInfoManager.swift
//  KDYWeChat
//
//  Created by mac on 16/10/14.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import AVOSCloud

/// 用户信息管理类
class UserInfoManager: NSObject {
    
    static let shareInstance = UserInfoManager()
    private override init() {
        super.init()
    }
    
    typealias successAction = () -> Bool
    typealias failureAction = (error: NSError) -> Void
    
    /**
     *  上传用户头像
     */
    func uploadUserAvatorInBackground(imageData: NSData,
                                      success: successAction,
                                      failure: failureAction) {
        
        
    }
    
    /**
     *  上传用户信息
     */
    
    /**
     *  获取用户信息
     */
}

