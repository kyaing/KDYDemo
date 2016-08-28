//
//  WBHeadView.m
//  KDYDemo
//
//  Created by zhongye on 16/2/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "WBHeadView.h"
#import "WBUSerModel.h"

@interface WBHeadView () {
    UIButton *_contactAvatarBtn;  //头像背景
    UIImageView *_imgAvatarView;  //头像
    UIImageView *_imgAvatarType;  //企业View,微博达人
    
    UIButton *_userVipBtn;        //昵称VIP
    UIImageView *_vipImageView;   //VIP
    UILabel *_userNameLabel;      //昵称
    
    UILabel *_timeLabel;          //时间
    UILabel *_sourceLabel;        //来源
}

@end

@implementation WBHeadView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupViews];
        [self setupFrames];
    }
    
    return self;
}

- (void)setupViews {
    //头像背景
    _contactAvatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _contactAvatarBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_contactAvatarBtn];
    
    //头像
    _imgAvatarView = [UIImageView new];
    _imgAvatarView.backgroundColor = [UIColor clearColor];
    [_contactAvatarBtn addSubview:_imgAvatarView];
    
    //用户类型
    _imgAvatarType = [UIImageView new];
    _imgAvatarType.backgroundColor = [UIColor clearColor];
    [_contactAvatarBtn addSubview:_imgAvatarType];
    
    //昵称VIP
    _userVipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userVipBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_userVipBtn];
    
    //昵称
    _userNameLabel = [UILabel new];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    _userNameLabel.font = TITLE_FONT_SIZE;
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNameLabel.textColor = RGB(231, 123, 59);
    [_userVipBtn addSubview:_userNameLabel];
    
    //VIP
    _vipImageView = [UIImageView new];
    _vipImageView.backgroundColor = [UIColor clearColor];
    _vipImageView.image = [UIImage imageNamed:@"common_icon_membership"];
    [_userVipBtn addSubview:_vipImageView];
    
    //发布时间
    _timeLabel = [UILabel new];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = SUBTITLE_FONT_SIZE;
    _timeLabel.textColor = RGB(148, 148, 148);
    [_userVipBtn addSubview:_timeLabel];
    
    //发布来源
    _sourceLabel = [UILabel new];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.font = SUBTITLE_FONT_SIZE;
    _sourceLabel.textAlignment = NSTextAlignmentLeft;
    _sourceLabel.textColor = RGB(148, 148, 148);
    [_userVipBtn addSubview:_sourceLabel];
}

- (void)setupFrames {
    _contactAvatarBtn.frame = CGRectMake(CELL_SIDEMARGIN, CELL_SIDEMARGIN, HEAD_CONTACTAVATARVIEW_HEIGHT,HEAD_CONTACTAVATARVIEW_HEIGHT);
    _imgAvatarView.frame = CGRectMake(0, 0, HEAD_IAMGE_HEIGHT, HEAD_IAMGE_HEIGHT);
    _imgAvatarType.frame = CGRectMake(22, 22, 18, 18);
    
    _userVipBtn.frame = CGRectMake(63, 12, 114, 19);
    _userNameLabel.frame=CGRectMake(0, 0, 106, 19);
    _vipImageView.frame=CGRectMake(108, 2, 14, 14);
    
    _timeLabel.frame=CGRectMake(63, CELL_SIDEMARGIN+23, 43, 12.0);
    _sourceLabel.frame=CGRectMake(111, CELL_SIDEMARGIN+23, 80, 12.0);
}

- (void)setHomeCellViewModel:(WBHomeCellViewModel *)homeCellViewModel {
    _homeCellViewModel = homeCellViewModel;
    WBUserModel *userModel = _homeCellViewModel.statusModel.user;
    
    [_imgAvatarView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url] placeholderImage:nil options:SDWebImageLowPriority];
}

@end

