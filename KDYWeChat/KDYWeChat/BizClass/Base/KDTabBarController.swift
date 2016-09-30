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
    
    
    var navigationControllers: NSMutableArray = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewControllers()
    }
    
    // 创建子控制器
    private func setupViewControllers() {
        // 标题
        let titleArray = ["微信", "通讯录", "发现", "我"]
        
        // 默认图片
        let normalImageArray = ["tabbar_mainframe",
                                "tabbar_contacts",
                                "tabbar_discover",
                                "tabbar_me"]
        
        // 选中图片
        let seletedImageArray = ["tabbar_mainframeHL",
                                 "tabbar_contactsHL",
                                 "tabbar_discoverHL",
                                 "tabbar_meHL"]
        // 控制器
        let controllerArray = [
            KDMessageViewController(),
            KDContactsViewController(),
            KDDiscoveryViewController(),
            KDMeViewController()
        ]
        
        // 设置tabarItem，并设置导航控制器
        for (index, controller) in controllerArray.enumerate() {
            // 设置标题和图片，注意改变图片的渲染模式
            controller.title = titleArray[index]
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
}

