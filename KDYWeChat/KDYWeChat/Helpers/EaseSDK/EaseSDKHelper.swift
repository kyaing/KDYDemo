//
//  EaseSDKHelper.swift
//  KDYWeChat
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

class EaseSDKHelper: NSObject, EMClientDelegate {

    // 注意Swift单例的定义方法
    // 这个位置使用 static，static修饰的变量会懒加载
    static let shareInstance = EaseSDKHelper()
    
    // 注意初始化方法应该是私有的，保证单例的真正唯一性！
    private override init() {}
    
    // MARK: - Init SDK
    func hyphenateApplication(application: UIApplication,
                              launchOptions: [NSObject: AnyObject]?,
                              appkey: NSString,
                              apnsCerName: NSString,
                              otherConfig: [NSObject: AnyObject]?) {
        
        self.setupAppDelegateNotifiction()
        self.registerRemoteNotification()
        
        
    }
    
    // MARK: - Private Methods
    /**
     *  注册Appdelegate的通知
     */
    func setupAppDelegateNotifiction() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.appDidEnterBackgroundNotif(_:)),
                                                         name: UIApplicationDidEnterBackgroundNotification,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.appWillEnterForegroundNotif(_:)),
                                                         name: UIApplicationWillEnterForegroundNotification,
                                                         object: nil)
    }
    
    func appDidEnterBackgroundNotif(notification: NSNotification) {
        // 进入后台时断开SDK
        EMClient.sharedClient().applicationDidEnterBackground(notification.object)
    }
    
    func appWillEnterForegroundNotif(notification: NSNotification) {
        // 即将进入前台时连接SDK
        EMClient.sharedClient().applicationWillEnterForeground(notification.object)
    }
    
    /**
     *  注册远程通知
     */
    func registerRemoteNotification() {
        
    }
    
    // MARK: - Send Message
    /**
     * 发送文本消息
     
     - parameter text:        文本内容
     - parameter toUser:      接收者
     - parameter messageType: 聊天类型
     - parameter messageExt:  消息扩展
     
     - returns: 返回 EmMessage 的文本消息
     */
    func sendTextMessage(text: NSString,
                         toUser: NSString,
                         messageType: EMChatType,
                         messageExt: NSDictionary) -> EMMessage? {
        
        return nil
    }
    
    /**
     *  发送图片消息
     */
    func sendImageMessage(text: NSString,
                          toUser: NSString,
                          messageType: EMChatType,
                          messageExt: NSDictionary) -> EMMessage? {
        
        return nil
    }
}

