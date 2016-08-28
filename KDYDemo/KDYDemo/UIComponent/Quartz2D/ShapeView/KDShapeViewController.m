//
//  KDShapeViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/5.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDShapeViewController.h"
#import "QuartzLineView.h"
#import "QuartzCurvesView.h"
#import "QuartzPolygonView.h"

@interface KDShapeViewController ()
@property (nonatomic, strong) NSMutableArray    *shapeBtn;
@property (nonatomic, strong) QuartzLineView    *lineView;
@property (nonatomic, strong) QuartzCurvesView  *curvesView;
@property (nonatomic, strong) QuartzPolygonView *polygonView;

@end

@implementation KDShapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基础图形";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLine];
    [self setupAnimationBtn];
}

- (void)setupAnimationBtn {
    self.shapeBtn = [[NSMutableArray alloc] initWithObjects:@"直线", @"圆弧", @"多边形", nil];
    
    for (int i = 0; i < _shapeBtn.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.frame = CGRectMake(20 + 70*i, kScreenHeight-100, 60, 30);
        [btn setTitle:_shapeBtn[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)clickBtnAction:(UIButton *)button {
    NSInteger index = button.tag;
    
    if (index == 0) {
        [self setupLine];
    } else if (index == 1) {
        [self setupCurves];
    } else {
        [self setupPolygon];
    }
}

- (void)setupLine {
    if (self.curvesView) {
        [self.curvesView removeFromSuperview];
    }
    if (self.polygonView) {
        [self.polygonView removeFromSuperview];
    }
    
    self.lineView = [[QuartzLineView alloc] init];
    self.lineView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-200);
    self.lineView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_lineView];
}

- (void)setupCurves {
    if (self.lineView) {
        [self.lineView removeFromSuperview];
    }
    if (self.polygonView) {
        [self.polygonView removeFromSuperview];
    }
    
    self.curvesView = [[QuartzCurvesView alloc] init];
    self.curvesView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-200);
    self.curvesView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.curvesView];
}

- (void)setupPolygon {
    if (self.lineView) {
        [self.lineView removeFromSuperview];
    }
    if (self.curvesView) {
        [self.curvesView removeFromSuperview];
    }
    
    self.polygonView = [[QuartzPolygonView alloc] init];
    self.polygonView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-200);
    self.polygonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.polygonView];
}

@end

