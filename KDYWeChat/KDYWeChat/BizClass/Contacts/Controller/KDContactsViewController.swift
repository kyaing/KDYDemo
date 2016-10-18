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
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        return tableView
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
    
    /**
     *  配置分组
     */
    func configureSections() {
        self.collation = UILocalizedIndexedCollation.currentCollation()
        
        var index = collation.sectionTitles.count
        let sectionTitlesCount = index
        
        let newSectionArray = NSMutableArray(capacity: sectionTitlesCount)
        
        for (index = 0; index < sectionTitlesCount; index += 1) {
            let array = NSMutableArray()
            newSectionArray.addObject(array)
        }
        
        for contact in contactsDataSource {
            let sectionNumber = collation.sectionForObject(contact, collationStringSelector: Selector("username"))
            let sectionObjs = newSectionArray.objectAtIndex(sectionNumber)
            sectionObjs.addObject(contact)
        }
        
        for (index = 0; index < sectionTitlesCount; index += 1) {
            let userObjsArrayForSection = newSectionArray.objectAtIndex(index)
            
            let sortedUserObjsArrayForSection = collation.sortedArrayFromArray(userObjsArrayForSection as! [AnyObject], collationStringSelector: Selector("username"))
            newSectionArray.replaceObjectAtIndex(index, withObject: sortedUserObjsArrayForSection)
        }

        self.sectionsArray = newSectionArray
        
        self.contactsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension KDContactsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return collation.sectionTitles.count > 0 ? collation.sectionTitles.count : 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contactsCell = tableView.dequeueReusableCellWithIdentifier(contactsIdentifier, forIndexPath: indexPath) as! ContactsTableCell
        
        // 设置Cell的数据
        let userNameInSection = sectionsArray.objectAtIndex(indexPath.section)
        let model = userNameInSection.objectAtIndex(indexPath.row) as! ContactModel
        
        contactsCell.usernameLabel.text = model.username
        
        return contactsCell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
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

