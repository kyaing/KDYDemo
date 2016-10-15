//
//  KDYWeChatHelper.swift
//  KDYWeChat
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

class KDYWeChatHelper: NSObject {
    
    var mainTabbarVC: KDTabBarController?
    var conversationVC: KDConversationViewController?
    var contactVC: KDContactsViewController?
    var chatVC: KDChatViewController?
    
    // MARK: - Life Cycle
    // 单例类
    static let shareInstance = KDYWeChatHelper()
    
    private override init() {
        super.init()
        self.initHeapler()
    }
    
    func initHeapler() {
        EMClient.sharedClient().addDelegate(self, delegateQueue: nil)
        EMClient.sharedClient().chatManager.addDelegate(self, delegateQueue: nil)
        EMClient.sharedClient().contactManager.addDelegate(self, delegateQueue: nil)
        EMClient.sharedClient().groupManager.addDelegate(self, delegateQueue: nil)
    }
    
    deinit {
        EMClient.sharedClient().removeDelegate(self)
        EMClient.sharedClient().chatManager.removeDelegate(self)
        EMClient.sharedClient().contactManager.removeDelegate(self)
        EMClient.sharedClient().groupManager.removeDelegate(self)
    }
    
    func clearHeapler() {
        self.mainTabbarVC = nil
    }
    
    // MARK: - Public Methods
    func asyncPushOptions() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            var error: EMError?
            EMClient.sharedClient().getPushOptionsFromServerWithError(&error)
        }
    }
    
    func asyncConversationFromDB() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let conversations: NSArray = EMClient.sharedClient().chatManager.getAllConversations()
            conversations.enumerateObjectsUsingBlock({ (conversation, idx, stop) in
    
                let conversation = conversation as! EMConversation
                if conversation.latestMessage == nil {
                    // 当会话最后一条信息为空，则删除此会话
                    EMClient.sharedClient().chatManager.deleteConversation(conversation.conversationId,
                        isDeleteMessages: false, completion: nil)
                }
            })
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            // 设置未读消息数
            if (self.mainTabbarVC != nil) {
                self.mainTabbarVC!.setupUnReadMessageCount()
            }
            
            // 刷新会话数据
            if (self.conversationVC != nil) {
                self.conversationVC!.refreshConversations()
            }
        }
    }
}

// MARK: - EMClientDelegate
extension KDYWeChatHelper: EMClientDelegate {
    /**
     *  监测sdk的网络状态
     */
    func connectionStateDidChange(aConnectionState: EMConnectionState) {
        if (self.mainTabbarVC != nil) {
            self.mainTabbarVC!.networkStateChanged(aConnectionState)
        }
    }
    
    /**
     *  自动登录失败时的回调
     */
    func autoLoginDidCompleteWithError(aError: EMError!) {
        
    }
    
    /**
     *  账号被从服务器删除
     */
    func userAccountDidRemoveFromServer() {
        
    }
    
    /**
     *  账号在其它设备登录
     */
    func userAccountDidLoginFromOtherDevice() {
        
    }
}

// MARK: - EMChatManagerDelegate
extension KDYWeChatHelper: EMChatManagerDelegate {
    /**
     *  会话列表发生更新
     */
    func conversationListDidUpdate(aConversationList: [AnyObject]!) {
        if (self.mainTabbarVC != nil) {
            self.mainTabbarVC!.setupUnReadMessageCount()
        }
        
        if (self.conversationVC != nil) {
            self.conversationVC!.refreshConversations()
        }
    }
    
    /**
     *  收到EMMessage消息
     */
    func messagesDidReceive(aMessages: [AnyObject]!) {
        for message in aMessages as! [EMMessage] {
            
            let needPushnotification = (message.chatType == EMChatTypeChat)
            if needPushnotification {
#if !TARGET_IPHONE_SIMULATOR
                let applicationState = UIApplication.sharedApplication().applicationState
                
                switch applicationState {
                case .Active, .Inactive:
                    if (self.mainTabbarVC != nil) {
                        self.mainTabbarVC!.playSoundAndVibration()
                    }
                case .Background:
                    if (self.mainTabbarVC != nil) {
                        self.mainTabbarVC!.showNotificationWithMessage(message)
                    }
                }
#endif
            }
        
            if (self.conversationVC != nil) {
                self.conversationVC!.refreshConversations()
            }
            
            if (self.mainTabbarVC != nil) {
                self.mainTabbarVC!.setupUnReadMessageCount()
            }
        }
    }
}

// MARK: - EMContactManagerDelegate
extension KDYWeChatHelper: EMContactManagerDelegate {
    
}

// MARK: - EMGroupManagerDelegate
extension KDYWeChatHelper: EMGroupManagerDelegate {
    
}

