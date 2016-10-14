//
//  KDRegisterViewController.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/10/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

class KDRegisterViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        self.setupViewsUI()
    }
    
    func setupViewsUI() {
        self.registerButton.enabled = false
        self.registerButton.layer.cornerRadius = 5
        self.registerButton.layer.masksToBounds = true
        self.registerButton.backgroundColor = UIColor(red: 168/255.0, green: 233/255.0, blue: 128/255.0, alpha: 0.8)
        
        self.cancelButton.setTitleColor(UIColor(colorHex: KDYColor.tabbarSelectedTextColor), forState: .Normal)
        
        // 修改光标颜色
        self.mailTextField.tintColor    = UIColor(colorHex: KDYColor.tabbarSelectedTextColor)
        self.accountTextField.tintColor = self.mailTextField.tintColor
        self.passwordTextFiled.tintColor = self.mailTextField.tintColor
    }

    // MARK: - Event Responses
    @IBAction func cancelButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func registerButtonAction(sender: AnyObject) {
        /**
         *  注册环信，并同时注册LeanClound，建立 _User表
         */
        
    }
    
    func hideKeyboard() {
        self.mailTextField.resignFirstResponder()
        self.accountTextField.resignFirstResponder()
        self.passwordTextFiled.resignFirstResponder()
    }
}

