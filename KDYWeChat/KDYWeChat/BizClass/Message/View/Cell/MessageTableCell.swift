//
//  MessageTableCell.swift
//  KDYWeChat
//
//  Created by kaideyi on 16/9/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

class MessageTableCell: UITableViewCell {
    
    @IBOutlet weak var avatorImage: UIImageView!
    @IBOutlet weak var unReadMsgLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var lastMsgDateLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lastMessageLabel.textColor = UIColor.grayColor()
        lastMsgDateLabel.textColor = UIColor.grayColor()
    }
}

