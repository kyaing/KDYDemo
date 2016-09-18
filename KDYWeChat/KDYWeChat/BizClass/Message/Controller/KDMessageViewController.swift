//
//  KDMessageViewController.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

let messageIdentifier: String = "messageCell"

/// 消息界面
final class KDMessageViewController: UIViewController {
    
    var msgDataArray = NSMutableArray()
    
    lazy var chatTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.backgroundColor = UIColor(colorHex: KDYColor.tableViewBackgroundColor)
        tableView.registerNib(UINib(nibName: "MessageTableCell", bundle: nil), forCellReuseIdentifier: messageIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(chatTableView)
        
        // 获取用户会话
        getAllConversation()
    }
    
    func getAllConversation() {
        // 获取用户所有会话，并排序
        let conversations: NSArray = EMClient.sharedClient().chatManager.getAllConversations()
        let sortedConversations: NSArray = conversations.sortedArrayUsingComparator { (Obj1, Obj2) -> NSComparisonResult in
            let message1: EMMessage = Obj1.latestMessage
            let message2: EMMessage = Obj2.latestMessage
            
            if message1.timestamp > message2.timestamp {
                return .OrderedAscending
            } else {
                return .OrderedDescending
            }
        }
        
        msgDataArray.removeAllObjects()
        for conversation in sortedConversations as! [EMConversation] {
            msgDataArray.addObject(conversation)
        }
        
        chatTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension KDMessageViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.msgDataArray.count > 0 ? self.msgDataArray.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let messageCell = tableView.dequeueReusableCellWithIdentifier(messageIdentifier, forIndexPath: indexPath) as! MessageTableCell
        
        let conversation = msgDataArray.objectAtIndex(indexPath.row) as! EMConversation
        messageCell.userNameLabel.text = conversation.conversationId
        
        return messageCell
    }
}

// MARK: - UITableViewDelegate
extension KDMessageViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let chatController = KDChatViewController()
        chatController.title = "消息"
        self.ky_pushAndHideTabbar(chatController)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
}

