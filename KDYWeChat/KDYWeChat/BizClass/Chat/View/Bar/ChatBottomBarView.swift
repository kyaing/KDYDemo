//
//  ChatBottomBarView.swift
//  KDYWeChat
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

/// 聊天页面底部条视图
final class ChatBottomBarView: UIView {
    
    // 聊天输入框
    @IBOutlet weak var inputTextView: UITextView! {
        didSet {
            inputTextView.layer.borderWidth   = 0.5
            inputTextView.layer.borderColor   = UIColor(rgba: "#C2C3C7").CGColor
            inputTextView.layer.cornerRadius  = 5.0
            inputTextView.layer.masksToBounds = true
            inputTextView.textContainerInset  = UIEdgeInsetsMake(5, 5, 5, 5)
            inputTextView.returnKeyType       = .Send
            inputTextView.font                = UIFont.systemFontOfSize(17)
            inputTextView.backgroundColor     = UIColor(rgba: "#f8fefb")
            inputTextView.hidden              = false
        }
    }
    
    // 录音按钮
    @IBOutlet weak var recordButton: UIButton! {
        didSet {
            recordButton.layer.cornerRadius  = 5.0
            recordButton.layer.masksToBounds = true
            recordButton.layer.borderColor   = UIColor(rgba: "#C2C3C7").CGColor
            recordButton.layer.borderWidth   = 0.5
            recordButton.hidden              = true
        }
    }
    
    // 语音按钮
    @IBOutlet weak var audioButton: UIButton!
    
    // 扩展按钮
    @IBOutlet weak var shareButton: UIButton!
    
    // 表情按钮
    @IBOutlet weak var emotionButton: UIButton!
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

