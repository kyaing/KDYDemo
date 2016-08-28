//
//  KDPlayerMaskView.m
//  KDYDemo
//
//  Created by kaideyi on 16/3/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDPlayerMaskView.h"

@interface KDPlayerMaskView ()

/** 头部渐变层 */
@property (nonatomic, strong) CAGradientLayer *topGradientLayer;

/** 底部渐变层 */
@property (nonatomic, strong) CAGradientLayer *bottomGradientLayer;

@end

@implementation KDPlayerMaskView

#pragma mark - Life Cycle 
- (instancetype)init {
    if (self = [super init]) {
        //创建顶部视图
        [self setupTopViews];
        
        //创建底部视图
        [self setupBottomViews];
        
        //设置keys
        [self setupMasKeys];
    }
    
    return self;
}

#pragma mark - Privates
- (void)setupMasKeys {
    _topImageView.mas_key = @"_topImageView";
}

- (void)setupTopViews {
    //顶部视图
    self.topImageView = [[UIImageView alloc] init];
    _topImageView.userInteractionEnabled = YES;
    [self addSubview:_topImageView];
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    //顶部视图的渐变层
    self.topGradientLayer = [CAGradientLayer layer];
    [_topImageView.layer addSublayer:_topGradientLayer];
    
    _topGradientLayer.startPoint = CGPointMake(0, 0);
    _topGradientLayer.endPoint = CGPointMake(0, 1);
    
    _topGradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                                 (__bridge id)[UIColor clearColor].CGColor];
    
    _topGradientLayer.locations = @[@(0.0), @(1.0)];
    
    //返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"play_back_full"] forState:UIControlStateNormal];
    [_topImageView addSubview:_backButton];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topImageView).offset(10);
        make.centerY.equalTo(_topImageView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //锁屏按钮
    self.lockScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lockScreenBtn ky_setButtonImage:@"unlock-nor"];
    [self addSubview:_lockScreenBtn];
    
    [_lockScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //屏幕暂停按钮
    self.pauseScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pauseScreenBtn ky_setButtonImage:@"kr-video-player-pause"];
    _pauseScreenBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _pauseScreenBtn.layer.borderWidth = 2.f;
    _pauseScreenBtn.layer.cornerRadius = 25;
    [self addSubview:_pauseScreenBtn];
    
    [_pauseScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

- (void)setupBottomViews {
    //底部视图
    self.bottomImageView = [[UIImageView alloc] init];
    _bottomImageView.userInteractionEnabled = YES;
    [self addSubview:_bottomImageView];
    
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    //底部视图的渐变层
    self.bottomGradientLayer = [CAGradientLayer layer];
    [_bottomImageView.layer addSublayer:_bottomGradientLayer];
    
    _bottomGradientLayer.startPoint = CGPointMake(0, 0);
    _bottomGradientLayer.endPoint = CGPointMake(0, 1);
    
    _bottomGradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                    (__bridge id)[UIColor blackColor].CGColor];
    
    _bottomGradientLayer.locations = @[@(0.0), @(1.0)];
    
    //开始或暂停按钮
    self.startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomImageView addSubview:_startBtn];
    
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomImageView).offset(10);
        make.centerY.equalTo(_bottomImageView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //当前播放时间
    self.currentTimeLabel = [[UILabel alloc] init];
    _currentTimeLabel.textAlignment = NSTextAlignmentLeft;
    _currentTimeLabel.font = [UIFont systemFontOfSize:13];
    _currentTimeLabel.textColor = [UIColor lightGrayColor];
    _currentTimeLabel.text = @"00:00";
    [_bottomImageView addSubview:_currentTimeLabel];
    
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startBtn.mas_right);
        make.centerY.equalTo(_bottomImageView);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    //全屏按钮
    self.fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fullScreenBtn ky_setButtonImage:@"kr-video-player-fullscreen"];
    [_bottomImageView addSubview:_fullScreenBtn];
    
    [_fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomImageView).offset(-10);
        make.centerY.equalTo(_bottomImageView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //总时间
    self.totalTimeLabel = [UILabel ky_createLabel:NSTextAlignmentRight
                                          fontNum:13
                                        textColor:[UIColor lightGrayColor]
                                             text:@"00:00"];
    [_bottomImageView addSubview:_totalTimeLabel];
    
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_fullScreenBtn.mas_left);
        make.centerY.equalTo(_bottomImageView);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    //缓冲条
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [_bottomImageView addSubview:_progressView];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_currentTimeLabel.mas_right).offset(5);
        make.right.equalTo(_totalTimeLabel.mas_left).offset(-5);
        make.centerY.equalTo(_bottomImageView);
        make.height.mas_equalTo(@2);
    }];
    
    //滑动块
    self.videoSlider = [[UISlider alloc] init];
    [_bottomImageView addSubview:_videoSlider];
    
    [_videoSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal]; //重新设置滑块图片
    _videoSlider.minimumTrackTintColor = [UIColor orangeColor];  //滑块滑过的颜色
    _videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];  //滑块未滑过的颜色
    
    [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_progressView);
        make.centerY.equalTo(_bottomImageView);
    }];
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _topGradientLayer.frame = _topImageView.bounds;
    _bottomGradientLayer.frame = _bottomImageView.bounds;
}

@end

