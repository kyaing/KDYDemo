//
//  KDLoginViewController.swift
//  KDYWeChat
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

class KDLoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏导航栏
        self.navigationController?.navigationBar.hidden = true
        
        // 登录环信
        //loginEmSDK(emUserName, password: emPassword)
    }
    
    // MARK: - Event Responses
    
    // MARK: - Private Methods
    func loginEmSDK(userName: NSString, password: NSString) {
        EMClient.sharedClient().loginWithUsername(emUserName, password: emPassword) { (name, error) in
            if (error != nil) {
                EMClient.sharedClient().options.isAutoLogin = true
            } else {
                print(">>环信登录成功<<")
            }
        }
    }
}

