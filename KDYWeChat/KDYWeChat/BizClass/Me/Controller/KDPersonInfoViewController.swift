//
//  KDPersonInfoViewController.swift
//  KDYWeChat
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

/// 个人信息界面
class KDPersonInfoViewController: UIViewController {

    lazy var infoTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        tableView.sectionIndexBackgroundColor = UIColor.clearColor()
        tableView.sectionIndexColor = UIColor.darkGrayColor()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人信息"
        self.infoTableView.reloadData()
    }
    
    func configureCells(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.textLabel?.font = UIFont.systemFontOfSize(16)
        cell.accessoryType  = .DisclosureIndicator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        let titleArray = [["头像", "名字", "微信号"], ["性别", "地区"]]
        cell.textLabel?.text = titleArray[indexPath.section][indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension KDPersonInfoViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var infoCell = tableView.dequeueReusableCellWithIdentifier("infoCell")
        if infoCell == nil {
            infoCell = UITableViewCell(style: .Value1, reuseIdentifier: "infoCell")
        }
        
        self.configureCells(infoCell!, indexPath: indexPath)
        
        return infoCell!
    }
}

// MARK: - UITableViewDelegate
extension KDPersonInfoViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 70
            }
        }
        
        return 44
    }
}

