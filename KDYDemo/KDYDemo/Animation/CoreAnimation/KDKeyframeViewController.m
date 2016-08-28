//
//  KDKeyframeAnimViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/4.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDKeyframeViewController.h"

@interface KDKeyframeViewController ()
@property (nonatomic, strong) UIView *testView;  //测试视图
@property (nonatomic, strong) NSMutableArray *animationBtn;

@end

@implementation KDKeyframeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基础动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.testView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, kScreenHeight/2-100, 100, 100)];
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
    
    //创建动画按钮
    [self setupAnimationBtn];
}

- (void)setupAnimationBtn {
    self.animationBtn = [[NSMutableArray alloc] initWithObjects:@"关键帧", @"路径", @"抖动", nil];
    
    for (int i = 0; i < _animationBtn.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.frame = CGRectMake(20 + 70*i, kScreenHeight-100, 60, 30);
        [btn setTitle:_animationBtn[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)clickBtnAction:(UIButton *)button {
    NSInteger index = button.tag;
    if (index == 0) {
        [self keyframeAnimation];
    } else if (index == 1) {
        [self pathAnimation];
    } else {
        [self shakeAnimaton];
    }
}

///关键帧
- (void)keyframeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, kScreenHeight/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/3, kScreenHeight/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/3, kScreenHeight/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth*2/3, kScreenHeight/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth*2/3, kScreenHeight/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth, kScreenHeight/2-50)];
    animation.values = @[value0, value1, value2, value3, value4, value5];
    animation.duration = 2.f;
    [self.testView.layer addAnimation:animation forKey:@"keyAnimation"];
}

///路径
- (void)pathAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kScreenWidth/2-100, kScreenHeight/2-100, 200, 200)];
    animation.path = path.CGPath;
    animation.duration = 2.f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.testView.layer addAnimation:animation forKey:@"pathAnimation"];
}

///抖动
- (void)shakeAnimaton {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    NSValue *value0 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value1 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:-M_PI/180*4];
    animation.values = @[value0, value1, value2];
    animation.repeatCount = 10;
    [self.testView.layer addAnimation:animation forKey:@"shapeAnimation"];
}

@end

