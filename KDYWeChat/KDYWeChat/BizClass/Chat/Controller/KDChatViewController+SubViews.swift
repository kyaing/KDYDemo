//
//  KDChatViewController+SubViews.swift
//  KDYWeChat
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

// MARK: - SubViews
extension KDChatViewController {
    
    func setupAllChildViews() {
        setupBottomBarView()
        setupChatTableView()
        setupEmotionKeyboard()
        setupShareKeyboard()
    }
    
    // 初始化底部视图
    func setupBottomBarView() {
        bottomBarView = NSBundle.mainBundle().loadNibNamed("ChatBottomBarView", owner: nil, options: nil).last as! ChatBottomBarView
        bottomBarView.backgroundColor = UIColor.redColor()
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
    
    // 初始化表格视图
    func setupChatTableView() {
        chatTableView.backgroundColor = UIColor.greenColor()
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
    
    // 初始化表情键盘
    func setupEmotionKeyboard() {
        emotionView = NSBundle.mainBundle().loadNibNamed("ChatEmotionView", owner: nil, options: nil).last as! ChatEmotionView
        emotionView.backgroundColor = UIColor.yellowColor()
        view.addSubview(emotionView)
        
        emotionView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(bottomBarView.snp_bottom)
            make.height.equalTo(kInputKeyboardHeight)
        }
    }
    
    // 初始化扩展键盘
    func setupShareKeyboard() {
        shareView = NSBundle.mainBundle().loadNibNamed("ChatShareMoreView", owner: nil, options: nil).last as! ChatShareMoreView
        shareView.backgroundColor = UIColor.blueColor()
        view.addSubview(shareView)
        
        shareView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(bottomBarView.snp_bottom)
            make.height.equalTo(kInputKeyboardHeight)
        }
    }
}

