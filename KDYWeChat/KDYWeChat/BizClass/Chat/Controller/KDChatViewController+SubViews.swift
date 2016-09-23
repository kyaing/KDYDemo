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
    
//    func setupChildViews() {
//        setupBottomBarView()
//        setupChatTableView()
//        setupEmotionKeyboard()
//        setupShareKeyboard()
//    }
//    
//    /**
//     * 初始化底部视图
//     */
//    func setupBottomBarView() {
//        bottomBarView = NSBundle.mainBundle().loadNibNamed("ChatBottomBarView", owner: nil, options: nil).last as! ChatBottomBarView
//        bottomBarView.delegate = self
//        bottomBarView.inputTextView.delegate = self
//        view.addSubview(bottomBarView)
//        
//        bottomBarView.snp_makeConstraints { (make) in
//            make.left.right.equalTo(self.view)
//            make.height.equalTo(kBarViewHeight)
//            
//            // BarView底部的约束
//            barPaddingBottomConstranit = make.bottom.equalTo(view.snp_bottom).constraint
//        }
//    }
//    
//    func setupChatTableView() {
//        view.backgroundColor = UIColor.whiteColor()
//        
//        chatTableView = UITableView(frame: CGRect.zero, style: .Plain)
//        chatTableView.backgroundColor = UIColor.clearColor()
//        chatTableView.tableFooterView = UIView()
//        chatTableView.separatorStyle = .SingleLine
//        chatTableView.dataSource = self
//        chatTableView.delegate = self
//        
//        view.addSubview(self.chatTableView)
//        
//        chatTableView.snp_makeConstraints { (make) in
//            make.top.left.right.equalTo(self.view)
//            make.bottom.equalTo(self.bottomBarView.snp_top)
//        }
//        
//        // 添加点击手势，隐藏所有键盘
//        let tapGesture = UITapGestureRecognizer()
//        tapGesture.cancelsTouchesInView = false
//        chatTableView.addGestureRecognizer(tapGesture)
//        tapGesture.rx_event.subscribeNext { _ in
//            self.hideAllKeyboard()
//            }.addDisposableTo(self.disposeBag)
//        
//        // 注册Cell
//        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatTextTableCell), bundle: nil), forCellReuseIdentifier: "ChatTextTableCell")
//        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatImageTableCell), bundle: nil), forCellReuseIdentifier: "ChatImageTableCell")
//        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatAudioTableCell), bundle: nil), forCellReuseIdentifier: "ChatAudioTableCell")
//        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatLocationTableCell), bundle: nil), forCellReuseIdentifier: "ChatLocationTableCell")
//        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatRedEnvelopeCell), bundle: nil), forCellReuseIdentifier: "ChatRedEnvelopeCell")
//    }
//    
//    /**
//     * 初始化表情键盘
//     */
//    func setupEmotionKeyboard() {
//        emotionView = NSBundle.mainBundle().loadNibNamed("ChatEmotionView", owner: nil, options: nil).last as! ChatEmotionView
//        emotionView.backgroundColor = UIColor.yellowColor()
//        view.addSubview(emotionView)
//        
//        emotionView.snp_makeConstraints { (make) in
//            make.left.right.equalTo(view)
//            make.height.equalTo(kInputKeyboardHeight)
//        }
//    }
//    
//    /**
//     * 初始化扩展键盘
//     */
//    func setupShareKeyboard() {
//        shareView = NSBundle.mainBundle().loadNibNamed("ChatShareMoreView", owner: nil, options: nil).last as! ChatShareMoreView
//        shareView.backgroundColor = UIColor.blueColor()
//        view.addSubview(shareView)
//        
//        shareView.snp_makeConstraints { (make) in
//            make.left.right.equalTo(view)
//            make.top.equalTo(bottomBarView.snp_bottom)
//            make.height.equalTo(kInputKeyboardHeight)
//        }
//    }
}

