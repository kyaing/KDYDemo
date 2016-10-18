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

    var contactsDataSource: NSMutableArray = []
    var sectionsArray: NSMutableArray = []
    var collation: UILocalizedIndexedCollation!
    
    lazy var contactsTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.registerNib(UINib(nibName: "ContactsTableCell", bundle: nil), forCellReuseIdentifier: contactsIdentifier)
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
    
    lazy var rightIndexLabel: UILabel = {
        let indexLabel = UILabel()
        indexLabel.userInteractionEnabled = true
        indexLabel.font = UIFont.systemFontOfSize(13)
        indexLabel.backgroundColor = UIColor.clearColor()
        indexLabel.textColor = UIColor.darkGrayColor()
        indexLabel.textAlignment = .Center
        indexLabel.numberOfLines = 0
        
        self.view.addSubview(indexLabel)
        
        return indexLabel
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model1 = ContactModel()
        let model2 = ContactModel()
        
        model1.username = "我是谁"
        model2.username = "qqewewe"
        
        contactsDataSource.addObject(model1)
        contactsDataSource.addObject(model2)
        
        self.configureSections()
    }
    
    // MARK: - Private Methods
    /**
     *  配置分组的内容
     */
    func configureSections() {
        self.collation = UILocalizedIndexedCollation.currentCollation()
        
        let index = collation.sectionTitles.count
        let sectionTitlesCount = index
        
        let newSectionArray = NSMutableArray(capacity: sectionTitlesCount)
        
        for _ in 0...index {
            let array = NSMutableArray()
            newSectionArray.addObject(array)
        }
        
        for contact in contactsDataSource {
            let sectionNumber = collation.sectionForObject(contact, collationStringSelector: Selector("username"))
            let sectionObjs = newSectionArray.objectAtIndex(sectionNumber)
            sectionObjs.addObject(contact)
        }
        
        for _ in 0...index {
            let userObjsArrayForSection = newSectionArray.objectAtIndex(index)
            
            let sortedUserObjsArrayForSection = collation.sortedArrayFromArray(userObjsArrayForSection as! [AnyObject], collationStringSelector: Selector("username"))
            newSectionArray.replaceObjectAtIndex(index, withObject: sortedUserObjsArrayForSection)
        }

        self.sectionsArray = newSectionArray
        self.contactsTableView.reloadData()
    }
    
    /**
     *  配置Cell内容
     */
    func configureCells(cell: ContactsTableCell, indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.usernameLabel.text = "新的朋友"
                cell.avatorImage.image = UIImage(named: "plugins_FriendNotify")
                
            } else if indexPath.row == 1 {
                cell.usernameLabel.text = "群聊"
                cell.avatorImage.image = UIImage(named: "add_friend_icon_addgroup")
                
            } else {
                cell.usernameLabel.text = "公众号"
                cell.avatorImage.image = UIImage(named: "add_friend_icon_offical")
            }
            
        } else {
            let userNameInSection = sectionsArray.objectAtIndex(indexPath.section)
            let model = userNameInSection.objectAtIndex(indexPath.row) as! ContactModel
            
            cell.usernameLabel.text = model.username
        }
    }
    
    /**
     *  配置进入下一个的界面
     */
    func configurePushControlelr(indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let newfriendController = KDNewFriendsViewController(nibName: "KDNewFriendsViewController", bundle: nil)
                self.ky_pushViewController(newfriendController, animated: true)
                
            } else if indexPath.row == 1 {
                
            } else {
                
            }
            
        } else {
            
        }
    }
}

// MARK: - UITableViewDataSource
extension KDContactsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return collation.sectionTitles.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        
        return sectionsArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contactsCell = tableView.dequeueReusableCellWithIdentifier(contactsIdentifier, forIndexPath: indexPath) as! ContactsTableCell
        
        // 设置Cell的数据
        self.configureCells(contactsCell, indexPath: indexPath)
        
        return contactsCell
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        
        headerView.textLabel?.font = UIFont.systemFontOfSize(14)
        headerView.textLabel?.textColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        
        let objsInSection = sectionsArray[section]
        guard objsInSection.count > 0 else { return nil }
        
        return collation.sectionTitles[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return collation.sectionIndexTitles
    }
}

// MARK: - UITableViewDelegate
extension KDContactsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.configurePushControlelr(indexPath)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // 添加备注按钮
        let noteRowAction = UITableViewRowAction(style: .Normal, title: "备注") { (rowAction, indexPath) in
            print(">>> 备注好友 <<<")
        }
        
        return [noteRowAction]
    }
}

