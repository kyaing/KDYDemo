//
//  PingPopTransition.m
//  KDYDemo
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "PingPopTransition.h"
#import "AniOneFromViewController.h"
#import "AniOneToViewController.h"

@interface PingPopTransition ()
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PingPopTransition

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    AniOneToViewController *fromVC = (AniOneToViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    AniOneFromViewController *toVC = (AniOneFromViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIButton *button = toVC.buttonOne;
    
    [containerView addSubview:toVC.view];   //这句话也不能少！
    [containerView addSubview:fromVC.view];
    
    //先创建大的UIBezierPath圆
    CGPoint finalPoint = CGPointMake(button.center.x, button.center.y - CGRectGetMaxY(toVC.view.bounds));
    CGFloat radius = sqrt(finalPoint.x * finalPoint.x + finalPoint.y * finalPoint.y);

    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];

    //再创建小的UIBezierPath圆
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:button.frame];

    //创建一个CAShapeLayer来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    fromVC.view.layer.mask = maskLayer;

    //创建一个关于Path的CABasicAnimation动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(maskFinalBP.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"pathInvert"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end

