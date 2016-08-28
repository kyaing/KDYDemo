//
//  KDPlayerMaskView.h
//  KDYDemo
//
//  Created by kaideyi on 16/3/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：视频播放需要的遮盖视图

#import <UIKit/UIKit.h>

@interface KDPlayerMaskView : UIView

/**
 *  顶部视图
 */
@property (nonatomic, strong) UIImageView *topImageView;

/** 
 *  返回按钮
 */
@property (nonatomic, strong) UIButton *backButton;

/**
 *  锁屏按钮
 */
@property (nonatomic, strong) UIButton *lockScreenBtn;

/**
 *  屏幕暂停按钮
 */
@property (nonatomic, strong) UIButton *pauseScreenBtn;

/**
 *  底部视图
 */
@property (nonatomic, strong) UIImageView *bottomImageView;

/**
 *  播放或暂停按钮
 */
@property (nonatomic, strong) UIButton *startBtn;

/**
 *  当前播放时间
 */
@property (nonatomic, strong) UILabel *currentTimeLabel;

/**
 *  总播放时间
 */
@property (nonatomic, strong) UILabel *totalTimeLabel;

/**
 *  缓冲进度条
 */
@property (nonatomic, strong) UIProgressView *progressView;

/**
 *  滑动条
 */
@property (nonatomic, strong) UISlider *videoSlider;

/**
 *  全屏按钮
 */
@property (nonatomic, strong) UIButton *fullScreenBtn;

@end

