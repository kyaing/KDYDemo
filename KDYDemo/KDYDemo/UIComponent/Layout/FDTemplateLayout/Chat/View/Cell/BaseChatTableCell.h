//
//  BaseChatTableCell.h
//  KDYDemo
//
//  Created by kaideyi on 16/1/31.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：聊天界面基类Cell，方便对不同类型进行扩展

#import <UIKit/UIKit.h>
#import "ChatModel.h"

#define kImageNameChat_Send_Nor        (@"SenderTextNodeBkg")
#define kImageNameChat_Send_HL         (@"SenderTextNodeBkgHL")

#define kImageNameChat_Recieve_Nor     (@"ReceiverTextNodeBkg")
#define kImageNameChat_Recieve_HL      (@"ReceiverTextNodeBkgHL")

@interface BaseChatTableCell : UITableViewCell {
    UIImageView  *headImageView;     //头像
    UIImageView  *bubbleImageView;   //气泡
    BOOL          isSender;          //是否是发送者
}

@property (nonatomic, strong) ChatModel *model;

/**
 *  长按气泡手势
 */
- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture;

@end

