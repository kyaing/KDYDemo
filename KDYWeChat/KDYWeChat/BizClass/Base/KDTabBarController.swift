//
//  KDTabBarController.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

/// TabBar
final class KDTabBarController: UITabBarController {
    
    /// 默认播放声音的间隔
    let kDefaultPlaySoundInterval = 3.0
    var lastPlaySoundDate: NSDate = NSDate()
    
    /// 联网状态
    var connectionState: EMConnectionState = EMConnectionConnected
    
    let conversationVC = KDConversationViewController()
    let contactVC      = KDContactsViewController()
    let discoveryVC    = KDDiscoveryViewController()
    let meVC           = KDMeViewController()
    
    var navigationControllers: NSMutableArray = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建子控制器
        setupViewControllers()
        
        // 监听通知
        setupNotification()
        
        // 未读消息数和未通过数
        setupUnReadMessageCount()
        setupUntreatedApplyCount()
    }

    private func setupViewControllers() {
        let titleArray = ["微信", "通讯录", "发现", "我"]
        
        let normalImageArray = ["tabbar_mainframe",
                                "tabbar_contacts",
                                "tabbar_discover",
                                "tabbar_me"]
    
        let seletedImageArray = ["tabbar_mainframeHL",
                                 "tabbar_contactsHL",
                                 "tabbar_discoverHL",
                                 "tabbar_meHL"]

        let controllerArray = [conversationVC, contactVC, discoveryVC, meVC]
        
        // 判断网络状态
        self.conversationVC.networkStateChanged(self.connectionState)
        
        // 设置tabarItem，并设置导航控制器
        for (index, controller) in controllerArray.enumerate() {
            // 设置标题和图片，改变图片的渲染模式
            controller.title            = titleArray[index]
            controller.tabBarItem.title = titleArray[index]
            controller.tabBarItem.image = UIImage(named: normalImageArray[index])?.imageWithRenderingMode(.AlwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: seletedImageArray[index])?.imageWithRenderingMode(.AlwaysOriginal)
            
            controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
            controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(colorHex: KDYColor.tabbarSelectedTextColor)], forState: .Selected)
            
            let navigation = KDNavigationController(rootViewController: controller)
            self.navigationControllers.addObject(navigation)
        }
        
        self.viewControllers = self.navigationControllers.mutableCopy() as? [KDNavigationController]
    }
    
    private func setupNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(KDTabBarController.setupUnReadMessageCount), name: unReadMessageCountNoti, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(KDTabBarController.setupUntreatedApplyCount), name: unTreatApplyCountNoti, object: nil)
    }
    
    // MARK: - Public Methods
    
    /**
     *  设置未读消息数目
     */
    func setupUnReadMessageCount() {
        let conversations: NSArray = EMClient.sharedClient().chatManager.getAllConversations()
        var unReadMsgCount: Int32 = 0
        
        for conversation in conversations {
            unReadMsgCount += conversation.unreadMessagesCount
        }
        
        if unReadMsgCount > 0 {
            self.conversationVC.tabBarItem.badgeValue = String("\(unReadMsgCount)")
        } else {
            self.conversationVC.tabBarItem.badgeValue = nil
        }
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = NSInteger(unReadMsgCount)
    }
    
    /**
     *  设置未处理的好友请求数目
     */
    func setupUntreatedApplyCount() {
        
    }
    
    /**
     *  监测网络状态变化
     */
    func networkStateChanged(connectionState: EMConnectionState) {
        self.connectionState = connectionState
        self.conversationVC.networkStateChanged(connectionState)
    }
    
    /**
     *  播放声音或振动(有新消息时)
     */
    func playSoundAndVibration() {        
        let timeInterval: NSTimeInterval = NSDate().timeIntervalSinceDate(self.lastPlaySoundDate)
        if timeInterval < kDefaultPlaySoundInterval {
            // 如果距离上次响铃和震动时间太短, 则跳过响铃
            print("skip ringing & vibration \(NSDate()), \(self.lastPlaySoundDate)")
            return;
        }
        
        self.lastPlaySoundDate = NSDate()
    }
    
    /**
     *  接收本地通知
     */
    func didReceviedLocalNotification(localNotification: UILocalNotification) {
        
    }
}

