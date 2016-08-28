//
//  PingTransition.m
//  KDYDemo
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "PingPushTransition.h"
#import "AniOneFromViewController.h"
#import "AniOneToViewController.h"

@interface PingPushTransition ()
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PingPushTransition

#pragma mark - UIViewControllerAnimatedTransitioning
//动画持续的时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

//自定义的转场动画
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    //先从transitionContext得到两个需要过渡的控制器
    AniOneFromViewController *fromVC = (AniOneFromViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    AniOneToViewController *toVC = (AniOneToViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    UIButton *fromButton = fromVC.buttonOne;
    
    //先创建第一个小的UIBezierPath圆
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:fromButton.frame];
    
    CGPoint finalPoint = CGPointMake(fromButton.center.x, fromButton.center.y - CGRectGetMaxY(toVC.view.bounds));
    CGFloat radius = sqrt(finalPoint.x * finalPoint.x + finalPoint.y * finalPoint.y);
    
    //再创建第二个大的UIBezierPath圆
    //重点掌握：CGRectInset(rect, dx, dy)的用法，请看##1
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(fromButton.frame, -radius, -radius)];
    
    //创建一个CAShapeLayer来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    //创建一个关于Path的CABasicAnimation动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(maskFinalBP.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

#pragma mark - ##1 CGRectInset & CGRectOffset
/**
 //此结构体的是以原rect为中心，参考dx, dy，进行缩小或放大的。正的表示缩小，负的表示放大。
 CGRect CGRectInset {
    CGRect rect, 
    CGFloat dx,
    CGFloat dy
 }
 
 //此结构体表示相对于源矩形原点(左上角的点)沿x和沿y轴偏移，在rect基础上沿x轴和y轴偏移，也就是将原点变化下。
 CGRect CGRectOffset {
    CGRect rect,
    CGFloat dx,
    CGFloat dy
 }
 
 //UIEdgeInsetsInsetRect：表示在原来的rect基础上根据边缘内切出一个rect出来。
 */

@end


