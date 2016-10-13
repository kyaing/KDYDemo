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
    @IBOutlet weak var accountTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏导航栏
        self.navigationController?.navigationBar.hidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        loginButton.enabled = false
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
    }
    
    // MARK: - Event Responses
    @IBAction func loginButtonAction(sender: AnyObject) {
        // 登录环信，并将用户信息存储于leanCloud
        //loginEmSDK(emUserName, password: emPassword)
        
        
    }
    
    @IBAction func moreButtonAction(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
      
        let changeAction   = UIAlertAction(title: "切换账号", style: .Default, handler: nil)
        let registerAction = UIAlertAction(title: "注册", style: .Default, handler: nil)
        let cancelAction   = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        
        // 修改显示的字体大小和颜色
        changeAction.setValue(UIColor(rgba: "#2a2a2a"), forKey: "_titleTextColor")
        registerAction.setValue(UIColor(rgba: "#2a2a2a"), forKey: "_titleTextColor")
        cancelAction.setValue(UIColor(rgba: "#7d7d7d"), forKey: "_titleTextColor")
        
        alertController.addAction(changeAction)
        alertController.addAction(registerAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func hideKeyboard() {
        self.accountTextFiled.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
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

// MARK: - UITextFieldDelegate
extension KDLoginViewController: UITextFieldDelegate {
    
}

