//
//  KDContactsViewController.swift
//  KDYWeChat
//
//  Created by mac on 16/10/17.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

let contactsIdentifier: String = "contactsCell"

/// 通讯录页面
final class KDContactsViewController: UIViewController {

    lazy var contactsTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.backgroundColor = UIColor(colorHex: KDYColor.tableViewBackgroundColor)
        tableView.registerNib(UINib(nibName: "ContactsTableCell", bundle: nil), forCellReuseIdentifier: contactsIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension KDContactsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contactsCell = tableView.dequeueReusableCellWithIdentifier(contactsIdentifier, forIndexPath: indexPath) as! ContactsTableCell
        
        // 设置
        
        return contactsCell
    }
}

// MARK: - UITableViewDelegate
extension KDContactsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

