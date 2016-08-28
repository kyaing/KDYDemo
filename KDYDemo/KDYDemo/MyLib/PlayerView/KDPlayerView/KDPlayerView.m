//
//  KDPlayerView.m
//  KDYDemo
//
//  Created by kaideyi on 16/3/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "KDPlayerMaskView.h"

@interface KDPlayerView ()

@property (nonatomic, strong) AVPlayer      *player;

@property (nonatomic, strong) AVPlayerItem  *playerItem;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

/** 水平快进快退label */
@property (nonatomic, strong) UILabel       *horizontalLabel;

/** 监控视频时长的定时器 */
@property (nonatomic, strong) NSTimer       *timer;

/** 遮罩视图 */
@property (nonatomic, strong) KDPlayerMaskView  *playerMaskView;

/** 是否显示遮罩视图 */
@property (nonatomic, assign) BOOL isShowMaskView;

@end

@implementation KDPlayerView

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = RGB(50, 50, 50);
        [self setupMaskViews];
    }
    
    return self;
}

- (void)dealloc {
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setter
- (void)setVideoURL:(NSURL *)videoURL {
    _videoURL = videoURL;
    
    //创建AVPlayer
    self.playerItem = [AVPlayerItem playerItemWithURL:videoURL];
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [self.layer insertSublayer:_playerLayer atIndex:0];
    
    if ([_playerLayer.videoGravity isEqualToString:AVLayerVideoGravityResizeAspect]) {
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    } else {
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    }
    [_player pause];
    
    if (_player.rate == 0) {
        [_playerMaskView.startBtn ky_setButtonImage:@"kr-video-player-pause"];
    } else {
        [_playerMaskView.startBtn ky_setButtonImage:@"kr-video-player-play"];
    }
    
    //遮罩视图的响应事件
    [self setupMaskViewResponse];
    
    //添加KVO和Noti
    [self setupPlayerItemKVOAndNoti];
    
    //添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(playerTimerAction) userInfo:nil repeats:YES];
    
    //默认显示遮罩
    self.isShowMaskView = YES;
    
    //添加屏幕点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreenAction:)];
    [self addGestureRecognizer:tapGesture];
}

#pragma mark - Privates
/**
 *  遮罩视图
 */
- (void)setupMaskViews {
    self.playerMaskView = [KDPlayerMaskView new];
    _playerMaskView.backgroundColor = [UIColor clearColor];
    [self addSubview:_playerMaskView];
    
    [_playerMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

/**
 *  遮罩中的响应事件
 */
- (void)setupMaskViewResponse {
    //返回按钮
    [self.playerMaskView.backButton addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //锁屏按钮
    [self.playerMaskView.lockScreenBtn addTarget:self action:@selector(lockBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //屏幕中央暂停按钮
    [self.playerMaskView.pauseScreenBtn addTarget:self action:@selector(pauseScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //播放或暂停按钮事件
    [self.playerMaskView.startBtn addTarget:self action:@selector(startBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //全屏按钮事件
    [_playerMaskView.fullScreenBtn addTarget:self action:@selector(fullScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //滑块滑块事件
    [_playerMaskView.videoSlider addTarget:self action:@selector(videoSliderChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_playerMaskView.videoSlider addTarget:self action:@selector(videoSliderDoneActoin:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  playerItem属性观察器和通知
 */
- (void)setupPlayerItemKVOAndNoti {
    //监听播放状态
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听播放时长等
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    [_playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    
    //视频播放完后发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
}

/**
 *  显示遮罩
 */
- (void)showMaskView {
    [UIView animateWithDuration:0.5 animations:^{
        _playerMaskView.alpha = 1;
    } completion:^(BOOL finished) {
        _isShowMaskView = NO;
    }];
}

/**
 *  隐藏遮罩
 */
- (void)hideMaskView {
    [UIView animateWithDuration:0.5 animations:^{
        _playerMaskView.alpha = 0;
    } completion:^(BOOL finished) {
        _isShowMaskView = YES;
    }];
}

/**
 *  获得视频的缓冲时间
 *
 *  @return 视频缓冲时间
 */
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    
    return result;
}

#pragma mark - Response Actions
- (void)backBtnAction:(UIButton *)button {
    [_player pause];
    [_timer invalidate];
    
    //block的使用：在需要向外传递的地方调用(下面的写法)；
    //在接受值的地方实现此block.
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)lockBtnAction:(UIButton *)button {
    if (button.selected) {
        [button ky_setButtonImage:@"lock-nor"];
    } else {
        [button ky_setButtonImage:@"unlock-nor"];
    }
    
    button.selected = !button.selected;
}

- (void)pauseScreenBtnAction:(UIButton *)button {
    if (!button.hidden) {
        //播放视频，并更改底部按钮
        [_player play];
        
        _playerMaskView.startBtn.selected = YES;
        [_playerMaskView.startBtn ky_setButtonImage:@"kr-video-player-play"];
    }
    
    button.hidden = YES;
}

- (void)startBtnAction:(UIButton *)button {
    if (button.selected) {
        [_player pause];
        [button ky_setButtonImage:@"kr-video-player-pause"];
        _playerMaskView.pauseScreenBtn.hidden = NO;
        
    } else {
        [_player play];
        [button ky_setButtonImage:@"kr-video-player-play"];
        _playerMaskView.pauseScreenBtn.hidden = YES;
    }
    
    button.selected = !button.selected;
}

- (void)fullScreenBtnAction:(UIButton *)button {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationPortraitUpsideDown:{
            //NSLog(@"fullScreenAction第3个旋转方向---电池栏在下");
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
            
        case UIInterfaceOrientationPortrait:{
            //NSLog(@"fullScreenAction第0个旋转方向---电池栏在上");
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
            
        case UIInterfaceOrientationLandscapeLeft:{
            //NSLog(@"fullScreenAction第2个旋转方向---电池栏在右");
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
            
        case UIInterfaceOrientationLandscapeRight:{
            //NSLog(@"fullScreenAction第1个旋转方向---电池栏在左");
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
            
        default:
            break;
    }
}

/**
 *  滑块滑动中
 */
- (void)videoSliderChangeAction:(UISlider *)slider {
    //确定视频已经播放
    if (_playerItem.status == AVPlayerItemStatusReadyToPlay) {
        //计算出拖动的当前秒数
        NSInteger totalSec = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale;
        NSInteger dragedSeconds = floorf(totalSec * slider.value);
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
        
        //更新当前时间的显示
        _playerMaskView.currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", totalSec/60, dragedSeconds];
        [_player pause];
        [_player seekToTime:dragedCMTime];
    }
}

/**
 *  滑块滑动停止
 */
- (void)videoSliderDoneActoin:(UISlider *)slider {
    if (_playerItem.status == AVPlayerItemStatusReadyToPlay) {
        //计算出拖动的当前秒数
        NSInteger totalSec = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale;
        NSInteger dragedSeconds = floorf(totalSec * slider.value);
        
        //转换成CMTime才能给player来控制播放进度
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
        [_player pause];
        [_player seekToTime:dragedCMTime completionHandler:^(BOOL finished) {
            [_player play];
            
            _playerMaskView.pauseScreenBtn.hidden = YES;
            _playerMaskView.startBtn.selected = YES;
            [_playerMaskView.startBtn ky_setButtonImage:@"kr-video-player-play"];
        }];
    }
}

/**
 *  定时器事件
 *  (显示相应的进度和时间)
 */
- (void)playerTimerAction {
    if (_playerItem.duration.timescale != 0) {
        //滑块进度
        _playerMaskView.videoSlider.maximumValue = 1;
        _playerMaskView.videoSlider.value = CMTimeGetSeconds([_playerItem currentTime]) / (_playerItem.duration.value / _playerItem.duration.timescale);
        
        //视频总时长
        NSInteger videoSeconds = (NSInteger)(_playerItem.duration.value / _playerItem.duration.timescale);
        
        //显示总时间
        NSInteger totoalMin, totoalSec;
        totoalSec = videoSeconds % 60;
        totoalMin = videoSeconds / 60;
        _playerMaskView.totalTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", totoalMin, totoalSec];
        
        //显示当前播放时间
        NSInteger cureentMin, cureentSec;
        cureentMin = (NSInteger)CMTimeGetSeconds([_playerItem currentTime]) / 60;
        cureentSec = (NSInteger)CMTimeGetSeconds([_playerItem currentTime]) % 60;
        _playerMaskView.currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", cureentMin, cureentSec];
    }
}

/**
 *  单击屏幕事件
 *
 *  @param gesture 单击手势
 */
- (void)tapScreenAction:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if (_isShowMaskView) {
            [self showMaskView];
        } else {
            [self hideMaskView];
        }
    }
}

#pragma mark - LayoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //把playerLayer加入到self.layer后，frame布局改变，那么设置playerLayer的frame布局
    self.playerLayer.frame = self.bounds;
}

#pragma mark - KVO & Notification
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == _playerItem) {
        if ([keyPath isEqualToString:@"status"]) {
            
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            NSTimeInterval timeInterval = [self availableDuration];  //得到缓冲进度
            CMTime duration = _playerItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            [_playerMaskView.progressView setProgress:timeInterval / totalDuration animated:NO];
            
        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
            
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            
        }
    }
}

- (void)videoDidPlayToEnd:(id)sender {
    _playerMaskView.pauseScreenBtn.hidden = NO;
    _playerMaskView.startBtn.selected = NO;
    [_playerMaskView.startBtn ky_setButtonImage:@"kr-video-player-pause"];
}

@end

