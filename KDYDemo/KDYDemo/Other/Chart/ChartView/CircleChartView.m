//
//  CircleChartView.m
//  KDYDemo
//
//  Created by zhongye on 15/12/1.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "CircleChartView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) * M_PI / 180.0)

@implementation CircleChartView

/**
 思路：
    其实核心的就是用UIBezierPath创建一段实时变化的圆弧线。即要用： bezierPathWithArcCenter:
    UIBezierPath + CAShapeLyaer + CAGradientLayer + CABasicAnimatin.
    CAShapeLyaer：每个CAShapeLayer对象都代表着将要被渲染到屏幕上的任意的形状，具体的形状是只能由path属性指定。
 */

- (id)initWithFrame:(CGRect)frame total:(NSNumber *)total current:(NSNumber *)current clockwise:(BOOL)clockwise {
    self = [super initWithFrame:frame];
    if (self) {
        _total = total;
        _current = current;
        _strokeColor = [UIColor blueColor];
        _duration = 1.0;
        _lineWidth = @10.f;
        
        //开始和结束的角度
        CGFloat startAngle = clockwise ? -90.0f : 270.0f;
        CGFloat endAngle = clockwise ? -90.01f : 270.01f;
        
        //为CAShapeLayer创建Path
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f) radius:(self.frame.size.height * 0.5) - ([_lineWidth floatValue]/2.0f) startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:clockwise];
        
        _circle = [CAShapeLayer layer];
        _circle.path = circlePath.CGPath;
        _circle.lineCap = kCALineCapRound;
        _circle.fillColor = [UIColor clearColor].CGColor;
        _circle.lineWidth = [_lineWidth floatValue];
        _circle.zPosition = 1;
        
        _circleBackground = [CAShapeLayer layer];
        _circleBackground.path  = circlePath.CGPath;
        _circleBackground.lineCap = kCALineCapRound;
        _circleBackground.fillColor = [UIColor clearColor].CGColor;
        _circleBackground.lineWidth = [_lineWidth floatValue];
        _circleBackground.strokeEnd = 1.0;
        _circleBackground.zPosition = -1;
        
        [self.layer addSublayer:_circle];
        [self.layer addSublayer:_circleBackground];
    }
    
    return self;
}

- (void)strokeChart
{
    //Add circle params
    _circle.lineWidth   = [_lineWidth floatValue];
    _circleBackground.lineWidth = [_lineWidth floatValue];
    _circleBackground.strokeEnd = 1.0;
    _circle.strokeColor = _strokeColor.CGColor;
    
    //为strokeEnd添加CABasicAnimation动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = self.duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @([_current floatValue] / [_total floatValue]);
    [_circle addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _circle.strokeEnd   = [_current floatValue] / [_total floatValue];
    
    //Check if user wants to add a gradient from the start color to the bar color
    if (_strokeColorGradientStart) {
        //Add gradient
        self.gradientMask = [CAShapeLayer layer];
        self.gradientMask.fillColor = [[UIColor clearColor] CGColor];
        self.gradientMask.strokeColor = [[UIColor blackColor] CGColor];
        self.gradientMask.lineWidth = _circle.lineWidth;
        self.gradientMask.lineCap = kCALineCapRound;
        CGRect gradientFrame = CGRectMake(0, 0, 2*self.bounds.size.width, 2*self.bounds.size.height);
        self.gradientMask.frame = gradientFrame;
        self.gradientMask.path = _circle.path;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0.5,1.0);
        gradientLayer.endPoint = CGPointMake(0.5,0.0);
        gradientLayer.frame = gradientFrame;
        UIColor *endColor = (_strokeColor ? _strokeColor : [UIColor greenColor]);
        NSArray *colors = @[(id)endColor.CGColor,
                            (id)_strokeColorGradientStart.CGColor];
        gradientLayer.colors = colors;
        [gradientLayer setMask:self.gradientMask];
        
        [_circle addSublayer:gradientLayer];
        self.gradientMask.strokeEnd = [_current floatValue] / [_total floatValue];
        [self.gradientMask addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
}

- (void)growChartByAmount:(NSNumber *)growAmount {
    NSNumber *updatedValue = [NSNumber numberWithFloat:[_current floatValue] + [growAmount floatValue]];
    
    //Add animation
    [self updateChartByCurrent:updatedValue];
}

- (void)updateChartByCurrent:(NSNumber *)current{
    [self updateChartByCurrent:current byTotal:_total];
}

- (void)updateChartByCurrent:(NSNumber *)current byTotal:(NSNumber *)total {
    //Add animation
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = self.duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @([_current floatValue] / [_total floatValue]);
    pathAnimation.toValue = @([current floatValue] / [total floatValue]);
    _circle.strokeEnd = [current floatValue] / [total floatValue];
    
    if (_strokeColorGradientStart) {
        self.gradientMask.strokeEnd = _circle.strokeEnd;
        [self.gradientMask addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    [_circle addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _current = current;
    _total = total;
}

@end

