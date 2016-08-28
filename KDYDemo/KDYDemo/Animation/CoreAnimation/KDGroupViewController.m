//
//  KDGroupAnimViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/5.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDGroupViewController.h"

@interface KDGroupViewController ()
@property (nonatomic, strong) UIView *testView;  //测试视图
@property (nonatomic, strong) NSMutableArray *animationBtn;

@end

@implementation KDGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"组动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.testView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, kScreenHeight/2-100, 100, 100)];
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
    
    //创建动画按钮
    [self setupAnimationBtn];
}

- (void)setupAnimationBtn {
    self.animationBtn = [[NSMutableArray alloc] initWithObjects:@"同时", @"连续", nil];
    
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
        [self groupAnimation1];
    } else {
        [self groupAnimation2];
    }
}

///同时进行组动画
- (void)groupAnimation1 {
    //位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, kScreenHeight/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/3, kScreenHeight/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/3, kScreenHeight/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth*2/3, kScreenHeight/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth*2/3, kScreenHeight/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth, kScreenHeight/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
    groupAnimation.duration = 4.0f;
    
    [self.testView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

///顺序进行动画
- (void)groupAnimation2 {
    CFTimeInterval currentTime = CACurrentMediaTime();
    //位移动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, kScreenHeight/2-75)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, kScreenHeight/2-75)];
    anima1.beginTime = currentTime;
    anima1.duration = 1.0f;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;
    [self.testView.layer addAnimation:anima1 forKey:@"aa"];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime+1.0f;
    anima2.duration = 1.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [self.testView.layer addAnimation:anima2 forKey:@"bb"];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime+2.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [self.testView.layer addAnimation:anima3 forKey:@"cc"];
}

@end

