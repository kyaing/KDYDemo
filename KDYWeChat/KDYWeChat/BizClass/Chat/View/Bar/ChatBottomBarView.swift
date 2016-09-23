//
//  ChatBottomBarView.swift
//  KDYWeChat
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

// MARK: -  ChatBarViewDelegate
protocol ChatBarViewDelegate: class {
    // 显示表情键盘
    func bottomBarViewShowEmotionKeyboard()
    
    // 显示扩展键盘
    func bottomBarViewShowShareKeyboard()
    
    // 隐藏所有自定义键盘当语音时
    func bottomBarViewHideKeyboardWhenVoice()
}

// MARK: - ChatBottomBarView
class ChatBottomBarView: UIView {
    
    // 键盘类型
    enum ChatBarKeyboardType: Int {
        case Default
        case Text
        case Emotion
        case Share
    }
    
    // 按着录音按钮
    @IBOutlet weak var recordButton: UIButton! {
        didSet {
            recordButton.layer.cornerRadius  = 5.0
            recordButton.layer.masksToBounds = true
            recordButton.layer.borderColor   = UIColor(rgba: "#C2C3C7").CGColor
            recordButton.layer.borderWidth   = 1.0
            recordButton.hidden = true
        }
    }
    
    // 文本输入框
    @IBOutlet weak var inputTextView: UITextView! {
        didSet {
            inputTextView.backgroundColor     = UIColor(rgba: "#f8fefb")
            inputTextView.layer.borderColor   = UIColor(rgba: "#C2C3C7").CGColor
            inputTextView.layer.borderWidth   = 1.0
            inputTextView.layer.cornerRadius  = 5.0
            inputTextView.layer.masksToBounds = true
            inputTextView.textContainerInset  = UIEdgeInsetsMake(10, 5, 5, 5)
            inputTextView.returnKeyType       = .Send
            inputTextView.font = UIFont.systemFontOfSize(16)
            inputTextView.hidden = false
        }
    }
    
    @IBOutlet weak var audioButton: ChatBarButton!
    @IBOutlet weak var emotionButton: ChatBarButton!
    @IBOutlet weak var shareButton: ChatBarButton!
    
    weak var delegate: ChatBarViewDelegate?
    var keyboardType: ChatBarKeyboardType? = .Default
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
        addBarLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBarLayer()
    }

    func addBarLayer() {
        let topView = UIView()
        let bottomeView = UIView()
        
        topView.backgroundColor = UIColor(rgba: "#C2C3C7")
        bottomeView.backgroundColor = UIColor(rgba: "#C2C3C7")
        
        addSubview(topView)
        addSubview(bottomeView)
        
        topView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(0.5)
        }
        
        bottomeView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
}

// MARK: - ChatBottomBarView Extension
extension ChatBottomBarView {
    // 改变按钮状态
    func setupBtnUIStatus() {
        audioButton.setImage(UIImage(named: "tool_voice_1"), forState: .Normal)
        audioButton.setImage(UIImage(named: "tool_voice_2"), forState: .Highlighted)
        
        emotionButton.setImage(UIImage(named: "tool_emotion_1"), forState: .Normal)
        emotionButton.setImage(UIImage(named: "tool_emotion_2"), forState: .Highlighted)
        
        shareButton.setImage(UIImage(named: "tool_share_1"), forState: .Normal)
        shareButton.setImage(UIImage(named: "tool_share_2"), forState: .Highlighted)
    }
    
    // 显示录音状态
    func showAudioRecording() {
        keyboardType = .Default
        
        inputTextView.hidden = true
        inputTextView.resignFirstResponder()
        
        recordButton.hidden = false
        audioButton.showTypingKeyboard   = true
        emotionButton.showTypingKeyboard = false
        shareButton.showTypingKeyboard   = false
    }
    
    // 显示文字输入键盘
    func showTypingKeyboard() {
        keyboardType = .Text
        
        inputTextView.hidden = false
        inputTextView.becomeFirstResponder()
        
        // 操作其它按钮
        recordButton.hidden = true
        audioButton.showTypingKeyboard   = false
        emotionButton.showTypingKeyboard = false
        shareButton.showTypingKeyboard   = false
    }
    
    // 显示表情键盘
    func showEmotionKeyboard() {
        keyboardType = .Emotion
        
        inputTextView.hidden = false
        inputTextView.resignFirstResponder()
        
        if let delegate = delegate {
            delegate.bottomBarViewShowEmotionKeyboard()
        }
        
        recordButton.hidden = true
        audioButton.showTypingKeyboard   = false
        emotionButton.showTypingKeyboard = true
        shareButton.showTypingKeyboard   = false
    }
    
    // 显示扩展键盘
    func showShardKeyboard() {
        keyboardType = .Share
        
        inputTextView.hidden = false
        inputTextView.resignFirstResponder()
        
        if let delegate = delegate {
            delegate.bottomBarViewShowShareKeyboard()
        }
        
        recordButton.hidden = true
        audioButton.showTypingKeyboard   = false
        emotionButton.showTypingKeyboard = false
        shareButton.showTypingKeyboard   = true
    }
 
    // 当显示表情或扩展键盘时，点击输入框
    func showTextKeyboard() {
        keyboardType = .Text
        
        inputTextView.hidden = false
        inputTextView.becomeFirstResponder()
        
        recordButton.hidden = true
        audioButton.showTypingKeyboard   = false
        emotionButton.showTypingKeyboard = false
        shareButton.showTypingKeyboard   = false
    }
    
    // 取消用户输入
    func resignKeyboardInput() {
        keyboardType = .Default
        
        inputTextView.resignFirstResponder()
        
        emotionButton.showTypingKeyboard = false
        shareButton.showTypingKeyboard   = false
    }
}

