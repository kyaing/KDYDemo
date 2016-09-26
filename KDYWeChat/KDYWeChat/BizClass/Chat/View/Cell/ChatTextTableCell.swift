//
//  ChatTextTableCell.swift
//  KDYWeChat
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import YYText

/// 聊天文本Cell
class ChatTextTableCell: ChatBaseTableCell {

    // 内容文本
    @IBOutlet weak var contentLabel: YYLabel! {
        didSet {
            
        }
    }
    
    // 聊天背景图片
    @IBOutlet weak var bubbleImageView: UIImageView! {
        didSet {
            
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // 设置文本内容
    override func setupCellContent(model: ChatModel) {
        super.setupCellContent(model)
        
        
    }
}

