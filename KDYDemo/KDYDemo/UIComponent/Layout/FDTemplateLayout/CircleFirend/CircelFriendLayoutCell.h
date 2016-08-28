//
//  CircelFriendLayoutCell.h
//  KDYDemo
//
//  Created by zhongye on 16/1/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleFriendModel.h"

//评论时，刷新Cell
typedef void (^CircelCommentBlock) ();

@interface CircelFriendLayoutCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) CircleFriendModel *circleModel;

@property (nonatomic, copy) CircelCommentBlock block;

@end

