//
//  KDQuartzOtherViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/6.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDQuartzOtherViewController.h"
#import "QuartzImageView.h"
#import "QuartzPatternView.h"
#import "QuartzGradientView.h"

@interface KDQuartzOtherViewController ()
@property (nonatomic, strong) NSMutableArray      *shapeBtn;
@property (nonatomic, strong) QuartzImageView     *imageView;
@property (nonatomic, strong) QuartzPatternView   *patternView;
@property (nonatomic, strong) QuartzGradientView  *gradientView;

@end

@implementation KDQuartzOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"其它图形";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupImage];
    [self setupAnimationBtn];
}

- (void)setupAnimationBtn {
    self.shapeBtn = [[NSMutableArray alloc] initWithObjects:@"Image", @"Pattern", @"渐变", nil];
    
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
        [self setupImage];
    } else if (index == 1) {
        [self setupPattern];
    } else {
        [self setupGradient];
    }
}

- (void)setupImage {
    if (self.patternView) {
        [self.patternView removeFromSuperview];
    }
    if (self.gradientView) {
        [self.gradientView removeFromSuperview];
    }
    
    self.imageView = [[QuartzImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-200);
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.imageView];
}

- (void)setupPattern {
    if (self.imageView) {
        [self.imageView removeFromSuperview];
    }
    if (self.gradientView) {
        [self.gradientView removeFromSuperview];
    }
    
    self.patternView = [QuartzPatternView new];
    self.patternView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-200);
    self.patternView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.patternView];
}

- (void)setupGradient {
    if (self.imageView) {
        [self.imageView removeFromSuperview];
    }
    if (self.patternView) {
        [self.patternView removeFromSuperview];
    }
    
    self.gradientView = [QuartzGradientView new];
    self.gradientView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-200);
    self.gradientView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.gradientView];
}

@end

