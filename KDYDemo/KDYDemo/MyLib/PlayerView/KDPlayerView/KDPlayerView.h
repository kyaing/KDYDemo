//
//  KDPlayerView.h
//  KDYDemo
//
//  Created by kaideyi on 16/3/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：视频播放的视图

#import <UIKit/UIKit.h>

/*
 实现的功能：
 - 遮罩视图(播放、暂停、全屏、显示当前进度、显示时间、锁屏等功能)
 - 左右滑动快进或快退
 - 上下滑动调节音量及屏幕亮度
 */

//定义返回的block
typedef void (^PlayerBackBlock) (void);

@interface KDPlayerView : UIView

/**
 *  视频地址
 */
@property (nonatomic, strong) NSURL *videoURL;

/**
 *  返回事件的block
 */
@property (nonatomic, copy) PlayerBackBlock backBlock;

@end

