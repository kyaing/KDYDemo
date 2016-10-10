//
//  KDConversationViewController.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

let messageIdentifier: String = "messageCell"

/// 会话界面
final class KDConversationViewController: UIViewController {
    
    var messageDataSource = NSMutableArray()
    
    lazy var conversationTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.backgroundColor = UIColor(colorHex: KDYColor.tableViewBackgroundColor)
        tableView.registerNib(UINib(nibName: "MessageTableCell", bundle: nil), forCellReuseIdentifier: messageIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    // 断网状态的头视图
    lazy var networkFailHeaderView: UIView = {
        let networkFailHeaderView: UIView = UIView(frame: CGRectMake(0, 0, self.conversationTableView.width, 44))
        networkFailHeaderView.backgroundColor = UIColor.redColor()
        
        let tipLabel = UILabel()
        tipLabel.textColor = UIColor.grayColor()
        tipLabel.backgroundColor = UIColor.clearColor()
        tipLabel.text = "当前网络有问题，请您检查网络"
        tipLabel.font = UIFont.systemFontOfSize(15)
        tipLabel.textAlignment = .Center
        networkFailHeaderView.addSubview(tipLabel)
        
        return networkFailHeaderView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(self.conversationTableView)
        
        registerChatDelegate()
        refreshConversations()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        unRegisterChatDelegate()
    }
    
    deinit {
        unRegisterChatDelegate()
    }
    
    // MARK: - Public Methods
    func networkStateChanged(connectionState: EMConnectionState) {
        if connectionState == EMConnectionDisconnected {   // 断网状态
            self.conversationTableView.tableHeaderView = self.networkFailHeaderView
            
        } else {
            self.conversationTableView.tableHeaderView = UIView()
        }
    }
    
    func refreshConversations() {
        // 获取用户会话
        getAllConversation()
    }
    
    // MARK: - Private Methods
    /**
     *  网络是否连接
     */
    func networkIsConnected() {
        
    }
    
    /**
     *  获得该用户的所有会话
     */
    private func getAllConversation() {
        let conversations: NSArray = EMClient.sharedClient().chatManager.getAllConversations()
        let sortedConversations: NSArray = conversations.sortedArrayUsingComparator { (Obj1, Obj2) -> NSComparisonResult in
            let message1 = Obj1 as! MessageModel
            let message2 = Obj2 as! MessageModel
            
            if message1.conversation.latestMessage.timestamp >
                message2.conversation.latestMessage.timestamp {
                return .OrderedAscending
            } else {
                return .OrderedDescending
            }
        }
        
        messageDataSource.removeAllObjects()
        
        for conversation in sortedConversations as! [EMConversation] {
            let model = MessageModel(conversation: conversation)
            self.messageDataSource.addObject(model)
        }
        
        conversationTableView.reloadData()
    }
    
    /**
     *  由数据模型，得到对应会话的最后一条消息
     */
    func getLastMessageForConversation(model: MessageModel) -> String? {
        var latestMsgTitle: String?
        
        let messageBody = model.conversation.latestMessage.body
        switch messageBody.type {
            
        // 只有文本消息，才有最后一条数据，其它都是自已拼的
        case EMMessageBodyTypeText:
            let textBody = messageBody as! EMTextMessageBody
            latestMsgTitle = textBody.text
            
        case EMMessageBodyTypeImage:    latestMsgTitle = "[图片]"
        case EMMessageBodyTypeVoice:    latestMsgTitle = "[语音]"
        case EMMessageBodyTypeVideo:    latestMsgTitle = "[视频]"
        case EMMessageBodyTypeLocation: latestMsgTitle = "[位置]"
        case EMMessageBodyTypeFile:     latestMsgTitle = "[文件]"
            
        default: latestMsgTitle = ""
        }
        
        return latestMsgTitle!
    }
    
    /**
     *  由数据模型，得到对应会话的最后一条消息的时间
     */
    func getlastMessageTimeForConversation(model: MessageModel) -> String {
        let lastMessage = model.conversation.latestMessage
        
        // 得到时间戳，把微秒转化成具体时间
        let seconds = Double(lastMessage.timestamp) / 1000
        let timeInterval: NSTimeInterval = NSTimeInterval(seconds)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let timeString = NSDate.messageAgoSinceDate(date)
        
        return timeString
    }
    
    func registerChatDelegate() {
        EMClient.sharedClient().chatManager.addDelegate(self, delegateQueue: nil)
    }
    
    func unRegisterChatDelegate() {
        EMClient.sharedClient().chatManager.removeDelegate(self)
    }
}

// MARK: - UITableViewDataSource
extension KDConversationViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageDataSource.count > 0 ? self.messageDataSource.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(messageIdentifier, forIndexPath: indexPath) as! MessageTableCell
        
        let model = messageDataSource.objectAtIndex(indexPath.row) as! MessageModel
        
        // 设置Cell的数据
        let lastMessage     = self.getLastMessageForConversation(model)
        let lastMessageTime = self.getlastMessageTimeForConversation(model)
        
        cell.avatorImageView.image  = model.avatarImage
        cell.unReadMsgLabel.text    = String("\(model.conversation.unreadMessagesCount)")
        cell.userNameLabel.text     = model.title
        cell.lastMessageLabel?.text = lastMessage
        cell.lastMsgDateLabel.text  = lastMessageTime
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension KDConversationViewController: UITableViewDelegate {
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

// MARK: - EMChatManagerDelegate
extension KDConversationViewController: EMChatManagerDelegate {
    func conversationListDidUpdate(aConversationList: [AnyObject]!) {
        
    }
}

