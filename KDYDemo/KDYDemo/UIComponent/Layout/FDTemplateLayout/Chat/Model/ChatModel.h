//
//  ChatModel.h
//  KDYDemo
//
//  Created by kaideyi on 16/1/31.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCellReuseIDWithSenderAndType(isSender, chatCellType)  \
        ([NSString stringWithFormat:@"%@-%@", isSender, chatCellType])

//根据模型得到可重用的Cell重用ID
#define kCellReuseID(model)   (([model.chatCellType integerValue] == TimeChatCellType) ? kTimeCellReusedID :(kCellReuseIDWithSenderAndType(model.isSender, model.chatCellType)))

/**
 *  Cell的消息类型
 */
typedef NS_ENUM(NSUInteger, ChatCellType) {
    /**
     *  文本类型
     */
    TextChatCellType = 1,
    /**
     *  图片类型
     */
    ImageChatCellType = 2,
    /**
     *  语音类型
     */
    AudioChatCellType = 3,
    /**
     *  视频类型
     */
    VideoChatCellType = 4,
    /**
     *  时间类型
     */
    TimeChatCellType = 0
};

@interface ChatModel : NSObject

@property (nonatomic, copy) NSString *isSender;         //是否是发送者
@property (nonatomic, copy) NSString *timeStamp;        //时间
@property (nonatomic, copy) NSString *chatCellType;     //Cell类型
@property (nonatomic, copy) NSString *content;          //消息内容
@property (nonatomic, copy) NSString *headImageURL;     //头像地址
@property (nonatomic, copy) NSString *imageViewURL;     //图片消息

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

