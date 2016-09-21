//
//  KDChatViewController+SubViews.swift
//  KDYWeChat
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

// 添加子视图
extension KDChatViewController {
    
    func setupAllChildViews() {
        setupBottomBarView()
        setupChatTableView()
        setupEmotionKeyboard()
        setupShareKeyboard()
    }
    
    // 底部条视图
    func setupBottomBarView() {
        bottomBarView = NSBundle.mainBundle().loadNibNamed("ChatBottomBarView", owner: nil, options: nil).last as! ChatBottomBarView
        bottomBarView.delegate = self
        bottomBarView.inputTextView.delegate = self
        view.addSubview(bottomBarView)
        
        bottomBarView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(kBarViewHeight)
            
            // BarView底部的约束
            barPaddingBottomConstranit = make.bottom.equalTo(view.snp_bottom).constraint
        }
    }
    
    // 聊天表格视图
    func setupChatTableView() {
        view.addSubview(chatTableView)
        
        // 注册Cell
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatTextTableCell), bundle: nil), forCellReuseIdentifier: "ChatTextTableCell")
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatImageTableCell), bundle: nil), forCellReuseIdentifier: "ChatImageTableCell")
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatAudioTableCell), bundle: nil), forCellReuseIdentifier: "ChatAudioTableCell")
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatLocationTableCell), bundle: nil), forCellReuseIdentifier: "ChatLocationTableCell")
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatRedEnvelopeCell), bundle: nil), forCellReuseIdentifier: "ChatRedEnvelopeCell")
        
        chatTableView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(bottomBarView.snp_top)
        }
    }
    
    // 创建表情键盘
    func setupEmotionKeyboard() {
        emotionView = NSBundle.mainBundle().loadNibNamed("ChatEmotionView", owner: nil, options: nil).last as! ChatEmotionView
        view.addSubview(emotionView)
        
        emotionView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(bottomBarView.snp_bottom)
            make.height.equalTo(kInputKeyboardHeight)
        }
    }
    
    // 创建扩展键盘
    func setupShareKeyboard() {
        shareView = NSBundle.mainBundle().loadNibNamed("", owner: nil, options: nil).last as! ChatShareMoreView
        view.addSubview(shareView)
        
        shareView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(bottomBarView.snp_bottom)
            make.height.equalTo(kInputKeyboardHeight)
        }
    }
}

