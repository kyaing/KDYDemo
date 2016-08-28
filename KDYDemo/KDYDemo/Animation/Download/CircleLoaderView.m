//
//  CircleLoaderView.m
//  KDYDemo
//
//  Created by zhongye on 15/12/2.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "CircleLoaderView.h"

@interface CircleLoaderView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) UIBezierPath *circlePath;

@end

@implementation CircleLoaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureLoader];
    }
    
    return self;
}

- (void)configureLoader {
    
    //创建UIBezierPath曲线(矩形的坐标点，没有确定好！)
    _circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.origin.x + 25, self.bounds.origin.y, 40.f, 40.f)];

    //创建CAShaperLayer
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.path = _circlePath.CGPath;
    _circleLayer.lineWidth = 2.f;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = [UIColor redColor].CGColor;
    _circleLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_circleLayer];
}

//依据下载进度，修改strokeEnd值
- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        _circleLayer.strokeStart = 0;
    } else if (progress > 1) {
        _circleLayer.strokeEnd = 1;
    } else {
        _circleLayer.strokeEnd = progress;
    }
}

- (CGFloat)progress {
    return _circleLayer.strokeEnd;
}

//在layoutSubviews更新circleLayer的frame来响应view的size变化
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    _circleLayer.frame = self.bounds;
//    _circleLayer.path = _circlePath.CGPath;
//}

- (void)reveal {
    
}

@end

