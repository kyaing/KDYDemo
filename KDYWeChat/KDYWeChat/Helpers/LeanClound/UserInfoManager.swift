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
    
    typealias successAction = (success: Bool) -> Void
    typealias failureAction = (error: NSError) -> Void
    
    /**
     *  上传用户头像
     */
    func uploadUserAvatorInBackground(image: UIImage, success: successAction, failure: failureAction) {
        
        var imageData: NSData?
        if UIImagePNGRepresentation(image) == nil {
            imageData = UIImageJPEGRepresentation(image, 1.0)!
        } else {
            imageData = UIImagePNGRepresentation(image)!
        }
        
        if imageData != nil {
            let userObject = AVObject(className: "_user")
            userObject.fetchInBackgroundWithBlock({ (object, error) in
//                let avatorFile = AVFile(name: "test.png", data: imageData)
                let currentId = AVUser.currentUser().objectId
                
                if (object != nil) {
                    if currentId == object.objectId {
                        print("1234567890-=")
                    }
                }
            })
        }
    }
    
    /**
     *  上传用户信息
     */
    
    /**
     *  获取用户信息
     */
}

