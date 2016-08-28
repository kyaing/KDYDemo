//
//  QQCuteView.m
//  KDYDemo
//
//  Created by zhongye on 15/11/26.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "QQCuteView.h"

/**
 initWithPoint: -> setup -> dragBubble: -> displayLink: -> drawRect
 */

@implementation QQCuteView {
    CGFloat r1;  //backView
    CGFloat r2;  //frontView
    CGFloat x1;
    CGFloat y1;
    CGFloat x2;
    CGFloat y2;
    CGFloat centerDistance;
    CGFloat cosDigree;
    CGFloat sinDigree;
    
    CGPoint pointA; //A
    CGPoint pointB; //B
    CGPoint pointD; //D
    CGPoint pointC; //C
    CGPoint pointO; //O
    CGPoint pointP; //P
    
    CGPoint initialPoint;
    CGPoint oldBackViewCenter;
    CGRect oldBackViewFrame;
    
    CAShapeLayer *shapeLayer;
    UIBezierPath *cutePath;
    UIView *backView;
}

#pragma mark - Life Cycle
- (id)initWithPoint:(CGPoint)point superView:(UIView *)view {
    self = [super initWithFrame:CGRectMake(point.x, point.y, self.bubuleWidth, self.bubuleWidth)];
    if (self) {
        initialPoint = point;
        self.containerView = view;
        
        [self.containerView addSubview:self];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUp];
    }
    
    return self;
}

- (void)setUp {
    shapeLayer = [CAShapeLayer layer];
    
    backView = [[UIView alloc] initWithFrame:self.frontView.frame];
    r1 = backView.bounds.size.width / 2;
    backView.layer.cornerRadius = r1;
    backView.backgroundColor = self.bubuleColor;
    [self.containerView addSubview:backView];
    
    self.frontView = [[UIView alloc] initWithFrame:CGRectMake(initialPoint.x, initialPoint.y, self.bubuleWidth, self.bubuleWidth)];
    r2 = self.frontView.bounds.size.width / 2;
    self.frontView.layer.cornerRadius = r2;
    self.frontView.backgroundColor = self.bubuleColor;
    [self.containerView addSubview:self.frontView];
    
    self.bubuleLabel = [[UILabel alloc] init];
    self.bubuleLabel.frame = CGRectMake(0, 0, self.frontView.frame.size.width, self.frontView.frame.size.height);
    self.bubuleLabel.textColor = [UIColor whiteColor];
    self.bubuleLabel.textAlignment = NSTextAlignmentCenter;
    [self.frontView insertSubview:self.bubuleLabel atIndex:0];
    [self.containerView addSubview:self.bubuleLabel];
    
    x1 = backView.center.x;
    y1 = backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    pointA = CGPointMake(x1-r1, y1);  // A
    pointB = CGPointMake(x1+r1, y1);  // B
    pointD = CGPointMake(x2-r2, y2);  // D
    pointC = CGPointMake(x2+r2, y2);  // C
    pointO = CGPointMake(x1-r1, y1);  // O
    pointP = CGPointMake(x2+r2, y2);  // P
    
    oldBackViewCenter = backView.center;
    oldBackViewFrame = backView.frame;
    
    backView.hidden = YES;  //先隐藏backView，为了看到frontView晃动的动画
    [self addAniLikeGameCenterBubble];
    
    //拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragBubble:)];
    [self.frontView addGestureRecognizer:pan];
}

- (void)dragBubble:(UIPanGestureRecognizer *)gesture {
    //得到手势作用的点
    CGPoint dragPoint = [gesture locationInView:self.containerView];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        backView.hidden = NO;
        [self removeAninWithGameCenterBubble];
        
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        self.frontView.center = dragPoint;
        if (r1 <= 6) {
            backView.hidden = YES;
            [shapeLayer removeFromSuperlayer];
        }
        
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled ||
               gesture.state == UIGestureRecognizerStateFailed) {
        backView.hidden = YES;
        [shapeLayer removeFromSuperlayer];
        
        [UIView animateWithDuration:0.5 delay:0.0f usingSpringWithDamping:0.4f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.frontView.center = oldBackViewCenter;
            
        } completion:^(BOOL finished) {
            if (finished) {
                [self addAniLikeGameCenterBubble];
            }
        }];
    }
    
    [self displayLinkAction:nil];
}

//每隔一帧刷新屏幕的定时器
- (void)displayLinkAction:(CADisplayLink *)disLink {
    x1 = backView.center.x;
    y1 = backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    centerDistance = sqrtf((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
    if (centerDistance == 0) {
        cosDigree = 1;
        sinDigree = 0;
    }else{
        cosDigree = (y2-y1)/centerDistance;
        sinDigree = (x2-x1)/centerDistance;
    }

    r1 = oldBackViewFrame.size.width / 2 - centerDistance/self.viscosity;
    
    pointA = CGPointMake(x1-r1*cosDigree, y1+r1*sinDigree);  // A
    pointB = CGPointMake(x1+r1*cosDigree, y1-r1*sinDigree);  // B
    pointD = CGPointMake(x2-r2*cosDigree, y2+r2*sinDigree);  // D
    pointC = CGPointMake(x2+r2*cosDigree, y2-r2*sinDigree);  // C
    pointO = CGPointMake(pointA.x + (centerDistance / 2)*sinDigree, pointA.y + (centerDistance / 2)*cosDigree);
    pointP = CGPointMake(pointB.x + (centerDistance / 2)*sinDigree, pointB.y + (centerDistance / 2)*cosDigree);
    
    [self drawRect];
}

- (void)drawRect {
    backView.center = oldBackViewCenter;
    backView.bounds = CGRectMake(0, 0, r1*2, r1*2);
    backView.layer.cornerRadius = r1;
    
    cutePath = [UIBezierPath bezierPath];
    [cutePath moveToPoint:pointA];
    [cutePath addQuadCurveToPoint:pointD controlPoint:pointO];
    [cutePath addLineToPoint:pointC];
    [cutePath addQuadCurveToPoint:pointB controlPoint:pointP];
    [cutePath moveToPoint:pointA];
    
    if (backView.hidden == NO) {
        shapeLayer.path = [cutePath CGPath];
        [self.containerView.layer insertSublayer:shapeLayer below:self.frontView.layer];
    }
}

//实现类似GameCenter一样的气泡晃动动画
- (void)addAniLikeGameCenterBubble {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 5.f;
    pathAnimation.repeatCount = INFINITY;
    
    //创建帧动画的路径path
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(self.frontView.frame, self.frontView.bounds.size.width / 2 - 3, self.frontView.bounds.size.width / 2 - 3);
    CGPathAddEllipseInRect(path, NULL, circleContainer);
    
    pathAnimation.path = path;
    CGPathRelease(path);
    [self.frontView.layer addAnimation:pathAnimation forKey:@"circelAnimation"];
    
    //X轴缩放
    CAKeyframeAnimation *scaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleXAnimation.duration = 1.f;
    scaleXAnimation.values = @[@1.0, @1.1, @1.0];
    scaleXAnimation.keyTimes = @[@0.0, @0.5, @1.0];
    scaleXAnimation.repeatCount = INFINITY;
    scaleXAnimation.autoreverses = YES;
    scaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleXAnimation forKey:@"scaleXAnimation"];
    
    //Y轴缩放
    CAKeyframeAnimation *scaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleYAnimation.duration = 1.f;
    scaleYAnimation.values = @[@1.0, @1.1, @1.0];
    scaleYAnimation.keyTimes = @[@0.0, @0.5, @1.0];
    scaleYAnimation.repeatCount = INFINITY;
    scaleYAnimation.autoreverses = YES;
    scaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleYAnimation forKey:@"scaleYAnimation"];
}

//移除动画
- (void)removeAninWithGameCenterBubble {
    [self.frontView.layer removeAllAnimations];
}

@end

