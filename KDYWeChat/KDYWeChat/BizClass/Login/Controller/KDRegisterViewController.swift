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
    @IBOutlet weak var phoneTextFiled: UITextField!
    @IBOutlet weak var verifiTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerButton.enabled = false
        self.registerButton.layer.cornerRadius = 5
        self.registerButton.layer.masksToBounds = true
        self.registerButton.backgroundColor = UIColor(colorHex: KDYColor.tabbarSelectedTextColor)
        self.cancelButton.setTitleColor(UIColor(colorHex: KDYColor.tabbarSelectedTextColor), forState: .Normal)
    }

    // MARK: - Event Responses
    @IBAction func cancelButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

