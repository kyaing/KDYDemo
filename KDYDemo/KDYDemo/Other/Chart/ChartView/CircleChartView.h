//
//  CircleChartView.h
//  KDYDemo
//
//  Created by zhongye on 15/12/1.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：圆形图表视图

#import <UIKit/UIKit.h>

@interface CircleChartView : UIView

@property (nonatomic) UIColor  *strokeColor;
@property (nonatomic) UIColor  *strokeColorGradientStart;
@property (nonatomic) NSNumber *total;
@property (nonatomic) NSNumber *current;
@property (nonatomic) NSNumber *lineWidth;
@property (nonatomic) NSTimeInterval duration;

@property (nonatomic) CAShapeLayer *circle;
@property (nonatomic) CAShapeLayer *gradientMask;
@property (nonatomic) CAShapeLayer *circleBackground;

@property (nonatomic) BOOL displayCountingLabel;

- (void)strokeChart;
- (void)growChartByAmount:(NSNumber *)growAmount;
- (void)updateChartByCurrent:(NSNumber *)current;
- (void)updateChartByCurrent:(NSNumber *)current byTotal:(NSNumber *)total;

- (id)initWithFrame:(CGRect)frame total:(NSNumber *)total current:(NSNumber *)current clockwise:(BOOL)clockwise;

@end

