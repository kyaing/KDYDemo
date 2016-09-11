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
    
    lazy var chatTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(chatTableView)
        chatTableView.backgroundColor = UIColor(colorHex: KDYColor.tableViewBackgroundColor)
        chatTableView.registerNib(UINib(nibName: "MessageTableCell", bundle: nil), forCellReuseIdentifier: messageIdentifier)
        chatTableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource
extension KDMessageViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let messageCell = tableView.dequeueReusableCellWithIdentifier(messageIdentifier, forIndexPath: indexPath) as! MessageTableCell
        
        return messageCell
    }
}

// MARK: - UITableViewDelegate
extension KDMessageViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
}

