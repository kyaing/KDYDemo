//
//  KDYChatHelper.swift
//  KDYWeChat
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

class KDYChatHelper: NSObject,
                     EMClientDelegate, EMChatManagerDelegate, EMContactManagerDelegate,
                     EMGroupManagerDelegate,EMChatroomManagerDelegate {
    
    let conversationVC = KDConversationViewController()
    let contactVC      = KDContactsViewController()
    let discoveryVC    = KDDiscoveryViewController()
    let meVC           = KDMeViewController()
    let mainTabbarVC   = KDTabBarController()
    
    // MARK: - Life Cycle
    // 单例
    static let shareInstance = KDYChatHelper()
    private override init() {
        super.init()
        self.initHeapler()
    }
    
    func initHeapler() {
        EMClient.sharedClient().addDelegate(self, delegateQueue: nil)
        EMClient.sharedClient().groupManager.addDelegate(self, delegateQueue: nil)
        EMClient.sharedClient().contactManager.addDelegate(self, delegateQueue: nil)
        EMClient.sharedClient().chatManager.addDelegate(self, delegateQueue: nil)
    }
    
    deinit {
        EMClient.sharedClient().removeDelegate(self)
        EMClient.sharedClient().groupManager.removeDelegate(self)
        EMClient.sharedClient().contactManager.removeDelegate(self)
        EMClient.sharedClient().chatManager.removeDelegate(self)
    }
    
    // MARK: - Public Methods
    func asyncPushOptions() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            var error: EMError?
            EMClient.sharedClient().getPushOptionsFromServerWithError(&error)
        }
    }
    
    func asyncConversationFromDB() {
        
    }
}

