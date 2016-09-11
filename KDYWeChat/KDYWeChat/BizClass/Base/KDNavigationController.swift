//
//  KDNavigationController.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

class KDNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavigationBar()
    }
    
    func initNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().translucent = true
        let attributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(19.0),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}
