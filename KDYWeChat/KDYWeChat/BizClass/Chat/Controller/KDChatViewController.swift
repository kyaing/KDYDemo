//
//  KDChatViewController.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

let kBarViewHeight: CGFloat        = 50
let kCustomKeyboardHeight: CGFloat = 216

/// 聊天界面 (学习TSWeChat)
final class KDChatViewController: UIViewController, UITextViewDelegate {
    
    lazy var chatTableView: UITableView = {
        let chatTableView = UITableView(frame: CGRect.zero, style: .Plain)
        chatTableView.backgroundColor = UIColor.clearColor()
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorStyle = .SingleLine
        
        return chatTableView
    }()

    var bottomBarView: ChatBottomBarView!
    var barPaddingBottomConstranit: Constraint?
    
    var emotionView: ChatEmotionView!
    var shareView: ChatShareMoreView!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 添加子视图
        setupChildViews()
        
        // 处理BarView的交互
        setupBarViewInteraction()
        
        // 键盘控制
        keyboardControl()
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
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            cell?.backgroundColor = UIColor.redColor()
        }
        cell?.textLabel?.text = NSString(string: "\(indexPath.row)") as String
        
        return cell!
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

