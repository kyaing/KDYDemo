//
//  QQHeaderView.h
//  KDYDemo
//
//  Created by zhongye on 15/12/10.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：自定义QQ头视图(注意这里继承UITableViewHeaderFooterView)

#import <UIKit/UIKit.h>
#import "FriendGroupModel.h"

@class QQHeaderView;

@protocol QQHeaderViewDelegate <NSObject>
@optional
- (void)clickHeaderView:(QQHeaderView *)headerView;

@end

@interface QQHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) FriendGroupModel *groupModel;
@property (nonatomic, weak  ) id <QQHeaderViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end

