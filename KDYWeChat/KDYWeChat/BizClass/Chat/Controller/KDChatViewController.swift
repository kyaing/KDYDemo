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
    
    var chatTableView: UITableView!
    var bottomBarView: ChatBottomBarView!
    var barPaddingBottomConstranit: Constraint?
    
    var emotionView: ChatEmotionView!
    var shareView: ChatShareMoreView!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加子视图
        setupChildViews()
        
        // 处理BarView的交互
        setupBarViewInteraction()
        
        // 键盘控制
        keyboardControl()
    }
    
    func setupChildViews() {
        setupBottomBarView()
        setupChatTableView()
        setupEmotionKeyboard()
        setupShareKeyboard()
    }
    
    /**
     * 初始化底部视图
     */
    func setupBottomBarView() {
        self.bottomBarView = NSBundle.mainBundle().loadNibNamed("ChatBottomBarView", owner: nil, options: nil).last as! ChatBottomBarView
        self.bottomBarView.delegate = self
        self.bottomBarView.inputTextView.delegate = self
        view.addSubview(self.bottomBarView)
        
        self.bottomBarView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(kBarViewHeight)
            
            // BarView底部的约束
            barPaddingBottomConstranit = make.bottom.equalTo(view.snp_bottom).constraint
        }
    }
    
    func setupChatTableView() {
        view.backgroundColor = UIColor.whiteColor()
        
        self.chatTableView = UITableView(frame: CGRect.zero, style: .Plain)
        self.chatTableView.backgroundColor = UIColor.clearColor()
        self.chatTableView.tableFooterView = UIView()
        self.chatTableView.separatorStyle = .SingleLine
        self.chatTableView.dataSource = self
        self.chatTableView.delegate = self
    
        view.addSubview(self.chatTableView)
        
        self.chatTableView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.bottomBarView.snp_top)
        }
        
        // 添加点击手势，隐藏所有键盘
        let tapGesture = UITapGestureRecognizer()
        tapGesture.cancelsTouchesInView = false
        self.chatTableView.addGestureRecognizer(tapGesture)
        tapGesture.rx_event.subscribeNext { _ in
            self.hideAllKeyboard()
            }.addDisposableTo(self.disposeBag)
        
        // 注册Cell
        self.chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatTextTableCell), bundle: nil), forCellReuseIdentifier: "ChatTextTableCell")
        self.chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatImageTableCell), bundle: nil), forCellReuseIdentifier: "ChatImageTableCell")
        self.chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatAudioTableCell), bundle: nil), forCellReuseIdentifier: "ChatAudioTableCell")
        self.chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatLocationTableCell), bundle: nil), forCellReuseIdentifier: "ChatLocationTableCell")
        self.chatTableView.registerNib(UINib.init(nibName: NSStringFromClass(ChatRedEnvelopeCell), bundle: nil), forCellReuseIdentifier: "ChatRedEnvelopeCell")
    }
    
    /**
     * 初始化表情键盘
     */
    func setupEmotionKeyboard() {
        self.emotionView = NSBundle.mainBundle().loadNibNamed("ChatEmotionView", owner: nil, options: nil).last as! ChatEmotionView
        self.emotionView.backgroundColor = UIColor.yellowColor()
        view.addSubview(self.emotionView)
        
        self.emotionView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(self.bottomBarView.snp_bottom)
            make.height.equalTo(kCustomKeyboardHeight)
        }
    }
    
    /**
     * 初始化扩展键盘
     */
    func setupShareKeyboard() {
        self.shareView = NSBundle.mainBundle().loadNibNamed("ChatShareMoreView", owner: nil, options: nil).last as! ChatShareMoreView
        self.shareView.backgroundColor = UIColor.blueColor()
        view.addSubview(self.shareView)
        
        self.shareView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(self.bottomBarView.snp_bottom)
            make.height.equalTo(kCustomKeyboardHeight)
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

