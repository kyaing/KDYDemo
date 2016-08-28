//
//  TimeChatTableCell.h
//  KDYDemo
//
//  Created by zhongye on 16/2/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "BaseChatTableCell.h"
#import "ChatModel.h"

#define kTimeCellReusedID    (@"CellTime")

/**
 *  这里时间标签的Cell不需要继承BaseChatTableCell，因为它不具有基类Cell的特征
 */
@interface TimeChatTableCell : UITableViewCell

@property (nonatomic, strong) ChatModel *model;

@end

