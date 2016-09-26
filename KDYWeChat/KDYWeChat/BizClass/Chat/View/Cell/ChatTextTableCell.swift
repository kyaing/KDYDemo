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

    // 聊天背景图片
    @IBOutlet weak var bubbleImageView: UIImageView!
    
    // 内容文本 (使用YYText处理)
    @IBOutlet weak var contentLabel: YYLabel! {
        didSet {
            contentLabel.backgroundColor = UIColor.clearColor()
            contentLabel.numberOfLines = 0
            contentLabel.displaysAsynchronously = false
            contentLabel.ignoreCommonProperties = true
            contentLabel.textVerticalAlignment = .Top
            contentLabel.font = UIFont.systemFontOfSize(16)
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // 设置文本内容
    override func setupCellContent(model: ChatModel) {
        super.setupCellContent(model)
    
        if let textLinePositionModifier = model.textLinePositionModifier {
            self.contentLabel.linePositionModifier = textLinePositionModifier
        }
        
        if let textLayout = model.textLayout {
            self.contentLabel.textLayout = textLayout
        }
        
        if let textAttributedString = model.textAttributedString {
            self.contentLabel.attributedText = textAttributedString
        }
        
        // 拉伸气泡图片
        let stretchImage = model.fromMe ? UIImage(named: "SenderTextNodeBkg") : UIImage(named: "ReceiverTextNodeBkg")
        let bubbleImage = stretchImage!.resizableImageWithCapInsets(UIEdgeInsetsMake(30, 28, 85, 28), resizingMode: .Stretch)
        self.bubbleImageView.image = bubbleImage
        
        self.setNeedsLayout()
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /**
     *  根据数据，计算高度
     */
    class func layoutCellHeigth(model: ChatModel) -> CGFloat {
        return 0
    }
}

