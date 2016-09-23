//
//  ChatBarButton+UI.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/22.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

// 按钮改变的状态
extension ChatBarButton {
    // 控制语音按钮切换成键盘图标
    func voiceButtonChangeToKeyboardUI(showKeyboard showKeyboard: Bool) {
        if showKeyboard {
            self.setImage(UIImage(named: "tool_keyboard_1"), forState: .Normal)
            self.setImage(UIImage(named: "tool_keyboard_2"), forState: .Highlighted)
            
        } else {
            self.setImage(UIImage(named: "tool_voice_1"), forState: .Normal)
            self.setImage(UIImage(named: "tool_voice_2"), forState: .Highlighted)
        }
    }
    
    // 控制表情按钮切换成键盘图标
    func emotionButtonChangeToKeyboardUI(showKeyboard showKeyboard: Bool) {
        if showKeyboard {
            self.setImage(UIImage(named: "tool_keyboard_1"), forState: .Normal)
            self.setImage(UIImage(named: "tool_keyboard_2"), forState: .Highlighted)
            
        } else {
            self.setImage(UIImage(named: "tool_emotion_1"), forState: .Normal)
            self.setImage(UIImage(named: "tool_emotion_2"), forState: .Highlighted)
        }
    }
}

