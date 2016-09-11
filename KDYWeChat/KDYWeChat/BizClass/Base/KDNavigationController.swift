//
//  KDNavigationController.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

/// 导航栏
class KDNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavigationBar()
    }
    
    func initNavigationBar() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        UINavigationBar.appearance().barTintColor = UIColor(colorHex: KDYColor.barTintColor)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().translucent = true
        let attributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(19),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}
