//
//  WBStatusCell.h
//  KDYDemo
//
//  Created by zhongye on 15/12/25.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：自定义微博首页的Cell

#import <UIKit/UIKit.h>
#import "YYKit.h"
#import "WBModel.h"
#import "WBStatusLayout.h"

/**
 思路：
    - 创建好各种子视图，最后组装好成一完整的Cell。
    - 在每个子视图中的控件，初始化时完成它们frame的计算。
      这里都是直接在init方法中计算frame。那么平时常在layoutSubviews计算frame。哪种更直接呢？
      而且也没有用懒加载创建子视图；这里也可以用masnory进行布局。
 */

@class WBStatusCell;
@protocol WBStatusCellDelegate;

#pragma mark - 标题
@interface WBStatusTitleView : UIView
@property (nonatomic, strong) YYLabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, weak)   WBStatusCell *cell;
@end

#pragma mark - 个人资料
@interface WBStatusProfileView : UIView
@property (nonatomic, strong) UIImageView *avatarView; ///< 头像
@property (nonatomic, strong) UIImageView *avatarBadgeView; ///< 徽章
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) YYLabel *sourceLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, assign) WBUserVerifyType verifyType;
@property (nonatomic, weak)   WBStatusCell *cell;
@end

#pragma mark - 卡片
@interface WBStatusCardView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak)   WBStatusCell *cell;
@end

#pragma mark - 标签
@interface WBStatusTagView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak)   WBStatusCell *cell;
@end

#pragma mark - 工具栏
@interface WBStatusToolbarView : UIView
@property (nonatomic, strong) UIButton *repostButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;

@property (nonatomic, strong) UIImageView *repostImageView;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UIImageView *likeImageView;

@property (nonatomic, strong) YYLabel *repostLabel;
@property (nonatomic, strong) YYLabel *commentLabel;
@property (nonatomic, strong) YYLabel *likeLabel;

@property (nonatomic, strong) CAGradientLayer *line1;
@property (nonatomic, strong) CAGradientLayer *line2;
@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, weak)   WBStatusCell *cell;

- (void)setWithLayout:(WBStatusLayout *)layout;
- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation;
@end

#pragma mark - 正文内容
@interface WBStatusView : UIView
@property (nonatomic, strong) UIView *contentView;              // 容器
@property (nonatomic, strong) WBStatusTitleView *titleView;     // 标题栏
@property (nonatomic, strong) WBStatusProfileView *profileView; // 用户资料
@property (nonatomic, strong) YYLabel *textLabel;               // 文本
@property (nonatomic, strong) NSArray *picViews;                // 图片 Array<UIImageView>
@property (nonatomic, strong) UIView *retweetBackgroundView;    //转发容器
@property (nonatomic, strong) YYLabel *retweetTextLabel;        // 转发文本
@property (nonatomic, strong) WBStatusCardView *cardView;       // 卡片
@property (nonatomic, strong) WBStatusTagView *tagView;         // 下方Tag
@property (nonatomic, strong) WBStatusToolbarView *toolbarView; // 工具栏
@property (nonatomic, strong) UIImageView *vipBackgroundView;   // VIP 自定义背景
@property (nonatomic, strong) UIButton *menuButton;             // 菜单按钮
@property (nonatomic, strong) UIButton *followButton;           // 关注按钮

@property (nonatomic, strong) WBStatusLayout *layout;
@property (nonatomic, weak)   WBStatusCell *cell;
@end

#pragma mark - Cell
@protocol WBStatusCellDelegate;
@interface WBStatusCell : UITableViewCell
@property (nonatomic, weak) id <WBStatusCellDelegate> delegate;
@property (nonatomic, strong) WBStatusView *statusView;

- (void)setStatusLayout:(WBStatusLayout *)layout;

@end

@protocol WBStatusCellDelegate <NSObject>

@optional
///点击了Cell
- (void)cellDidClick:(WBStatusCell *)cell;

///点击了 Card
- (void)cellDidClickCard:(WBStatusCell *)cell;

///点击了转发
- (void)cellDidClickRepost:(WBStatusCell *)cell;

///点击了评论
- (void)cellDidClickComment:(WBStatusCell *)cell;

///点击了赞
- (void)cellDidClickLike:(WBStatusCell *)cell;

///点击了用户
- (void)cell:(WBStatusCell *)cell didClickUser:(WBUser *)user;

@end

