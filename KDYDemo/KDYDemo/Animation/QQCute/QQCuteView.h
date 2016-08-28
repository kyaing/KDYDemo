//
//  QQCuteView.h
//  KDYDemo
//
//  Created by zhongye on 15/11/26.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：自定义QQ的消息未读数字(这个是不是就要自定义tabbar呢？)

#import <UIKit/UIKit.h>

/**
 描述：
 这个思路还是没想好！
 做的过程中，需要动手画图帮助理解动画的实现。
 主要主是六个点的确定，以及怎么根据这些点绘制UIBezierPath曲线。
 
 */

@interface QQCuteView : UIView

@property (nonatomic, strong) UIView  *containerView; //父视图
@property (nonatomic, strong) UILabel *bubuleLabel;   //气泡上的数字
@property (nonatomic, strong) UIColor *bubuleColor;   //气泡的颜色
@property (nonatomic, assign) CGFloat  bubuleWidth;   //气泡的宽度
@property (nonatomic, assign) CGFloat  viscosity;     //气泡的粘性系数
@property (nonatomic, strong) UIView  *frontView;     //需要隐藏的视图

- (id)initWithPoint:(CGPoint)point superView:(UIView *)view;
- (void)setUp;

@end

