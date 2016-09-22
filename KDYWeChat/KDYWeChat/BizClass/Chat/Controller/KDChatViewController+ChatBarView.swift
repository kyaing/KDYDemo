//
//  KDChatViewController+ChatBarView.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/22.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - ChatBarView
extension KDChatViewController {
    
    /**
     *  处理ChatBatView各个按钮，如语音，表情，扩展及录音按钮的点击和交互
     */
    func setupBarViewInteraction() {
        let audioButton: ChatBarButton   = bottomBarView.audioButton
        let emotionButton: ChatBarButton = bottomBarView.emotionButton
        let shareButton: ChatBarButton   = bottomBarView.shareButton
        let recordButton: UIButton       = bottomBarView.recordButton
        
        // 点击语音按钮
        audioButton.rx_tap.subscribeNext { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.bottomBarView.setupBtnUIStatus()
            
            let showRecording = strongSelf.bottomBarView.recordButton.hidden
            if showRecording {
                
            } else {
                
            }
            
        }.addDisposableTo(disposeBag)
        
        // 点击表情按钮
        emotionButton.rx_tap.subscribeNext { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.bottomBarView.setupBtnUIStatus()
            
            
        }.addDisposableTo(disposeBag)
        
        // 点击扩展按钮
        shareButton.rx_tap.subscribeNext { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.bottomBarView.setupBtnUIStatus()
            
            
        }.addDisposableTo(disposeBag)
        
        // 按着录音按钮(为此加长按手势)
        let longPressGesture = UILongPressGestureRecognizer()
        recordButton.addGestureRecognizer(longPressGesture)
        longPressGesture.rx_event.subscribeNext { [weak self] _ in
            guard let strongSelf = self else { return }
            
            
        }.addDisposableTo(disposeBag)
    }
}

// MARK: - ChatBarViewDelegate
extension KDChatViewController: ChatBarViewDelegate {
    
    func bottomBarViewShowEmotionKeyboard() {
        
    }
    
    func bottomBarViewShowShareKeyboard() {
        
    }
    
    func bottomBarViewHideKeyboardWhenRecord() {
        
    }
}

