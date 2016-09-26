//
//  KDChatViewController+ChatCells.swift
//  KDYWeChat
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

// MARK: - 聊天Cells
extension MessageContentType {
    func chatCellHeight(model: ChatModel) -> CGFloat {
        switch self {
        case .Text:
            return ChatTextTableCell.layoutCellHeigth(model)
            
        default:
            return 40
        }
    }
}

