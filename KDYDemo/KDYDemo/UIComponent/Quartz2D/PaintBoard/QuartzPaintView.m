//
//  QuartzPaintView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "QuartzPaintView.h"

@implementation QuartzPaintView

#pragma mark - Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:self];
    
    //曲线
    _myBezierPath = [[UIBezierPath alloc] init];
    _myBezierPath.lineWidth = 2.f;
    _myBezierPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    _myBezierPath.lineJoinStyle = kCGLineJoinRound;  //终点处理
    [_myBezierPath moveToPoint:startPoint];
    
    //shapeLayer
    _myShapeLayer = [CAShapeLayer layer];
    _myShapeLayer.path = _myBezierPath.CGPath;
    _myShapeLayer.lineWidth = 2.f;
    _myShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    _myShapeLayer.fillColor = [UIColor clearColor].CGColor;  //封闭曲线，设置fillColor
    _myShapeLayer.lineCap = kCALineCapRound;
    _myShapeLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_myShapeLayer];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获得移动点
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    
    if ([event allTouches].count > 1) {
        [self.superview touchesMoved:touches withEvent:event];
    } else if ([event allTouches].count == 1) {
        [_myBezierPath addLineToPoint:movePoint];
        _myShapeLayer.path = _myBezierPath.CGPath;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([event allTouches].count > 1){
        [self.superview touchesMoved:touches withEvent:event];
    }
}

@end
