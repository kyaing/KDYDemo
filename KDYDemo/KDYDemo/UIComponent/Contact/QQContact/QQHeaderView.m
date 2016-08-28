//
//  QQHeaderView.m
//  KDYDemo
//
//  Created by zhongye on 15/12/10.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "QQHeaderView.h"

@interface QQHeaderView ()
@property (nonatomic, strong) UIButton *headerBtn;    /** 头部按钮 */
@property (nonatomic, strong) UILabel  *onlineLabel;  /** 在线人数 */

@end

@implementation QQHeaderView

#pragma mark - Init
+ (instancetype)headViewWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"header";
    QQHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:identifer];
    }
    
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupHeaderView];
    }
    
    return self;
}

- (void)setupHeaderView {
    //头部按钮
    self.headerBtn = [[UIButton alloc] init];
    [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
    [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
    [self.headerBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [self.headerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headerBtn addTarget:self action:@selector(headerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];  //设置按钮内容的对齐方式
    [self.headerBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];  //设置按钮内容的边距
    [self.headerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];  //设置按钮中文本
    [self.headerBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    self.headerBtn.imageView.contentMode = UIViewContentModeCenter;  //此模式意思是大小不变，位置居中
    self.headerBtn.imageView.clipsToBounds = NO;
    [self.contentView addSubview:self.headerBtn];
    
    //在线人数
    self.onlineLabel = [[UILabel alloc] init];
    self.onlineLabel.textAlignment = NSTextAlignmentRight;
    self.onlineLabel.font = [UIFont systemFontOfSize:16];
    self.onlineLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.onlineLabel];
}

- (void)headerBtnClick {
    //设置分组打开的状态
    self.groupModel.opened = !self.groupModel.isOpened;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickHeaderView:)]) {
        [self.delegate clickHeaderView:self];
    }
}

/**
 当一个控件被添加到父控件中就会调用
 在这里控制控制组左边图片的旋转
 
 为什么在这里控制图片的旋转呢？
 当某组的headerView中的nameView被点击，触发了nameViewClick方法，该组的opened状态改变，然后控制器刷新数据，
 注意这里的刷新数据，会把之前UITableView中的数据全部销毁，然后全部重新创建，重新创建就需要把headerView添加到UITableView中。
 所以didMoveToSuperView在每次刷新数据后都会调用，也就是每次点击nameView后都会调用
 */
- (void)didMoveToSuperview {
    self.headerBtn.imageView.transform = CGAffineTransformIdentity;
    
    if (self.groupModel.opened) {
        [UIView animateWithDuration:0.2 animations:^{
            self.headerBtn.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.headerBtn.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
        }];
    }
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //按钮
    self.headerBtn.frame = self.bounds;
 
    //在线人数标签
    self.onlineLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 80, 0, 70, CGRectGetHeight(self.frame));
}

#pragma mark - Data
- (void)setGroupModel:(FriendGroupModel *)groupModel {
    _groupModel = groupModel;
    
    //设置组名
    [self.headerBtn setTitle:groupModel.name forState:UIControlStateNormal];
    
    //设置在线人数
    [self.onlineLabel setText:[NSString stringWithFormat:@"%ld/%ld", groupModel.online, groupModel.friends.count]];
}

@end

