//
//  KDChatViewController.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import SnapKit

let kBarViewHeight = 50
let kShowHeight    = 216

/// 聊天界面
final class KDChatViewController: UIViewController, UITextViewDelegate {
    
    lazy var chatTableView: UITableView = {
        let chatTableView = UITableView(frame: self.view.bounds, style: .Plain)
        chatTableView.backgroundColor = UIColor.clearColor()
        chatTableView.tableFooterView = UIView()
        chatTableView.separatorStyle = .None
        chatTableView.dataSource = self
        chatTableView.delegate = self
    
        return chatTableView
    }()
    
    var chatBottomBarView: ChatBottomBarView!
    var chatBarPaddingBottomConstranit: Constraint?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册Cell
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatTextTableCell), bundle: nil), forCellReuseIdentifier: "ChatTextTableCell")
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatImageTableCell), bundle: nil), forCellReuseIdentifier: "ChatImageTableCell")
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatAudioTableCell), bundle: nil), forCellReuseIdentifier: "ChatAudioTableCell")
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatLocationTableCell), bundle: nil), forCellReuseIdentifier: "ChatLocationTableCell")
        chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatRedEnvelopeCell), bundle: nil), forCellReuseIdentifier: "ChatRedEnvelopeCell")
        
        // 创建子视图
        setupSubViews()
    }
    
    func setupSubViews() {
        setupBottomBarView()
        setupChatTableView()
    }
    
    // 底部条视图
    func setupBottomBarView() {
        chatBottomBarView = NSBundle.mainBundle().loadNibNamed("ChatBottomBarView", owner: nil, options: nil).last as! ChatBottomBarView
        chatBottomBarView.delegate = self
        chatBottomBarView.inputTextView.delegate = self
        view.addSubview(chatBottomBarView)
        
        chatBottomBarView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(kBarViewHeight)
            
            // BarView底部的约束
            chatBarPaddingBottomConstranit = make.bottom.equalTo(view.snp_bottom).constraint
        }
    }
    
    // chatTableView
    func setupChatTableView() {
        view.addSubview(chatTableView)
        
        chatTableView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(chatBottomBarView.snp_top)
        }
    }
}

// MARK: - UITableViewDataSource
extension KDChatViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()

    }
}

// MARK: - UITableViewDelegate
extension KDChatViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}

