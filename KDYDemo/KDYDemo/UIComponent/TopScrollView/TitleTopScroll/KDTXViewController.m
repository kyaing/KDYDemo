//
//  KDTXViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/11.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDTXViewController.h"
#import "KDChildViewController.h"

@interface KDTXViewController ()

@end

@implementation KDTXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.
 
    self.title = @"腾讯视频";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isShowTitleGradient = YES;
    self.titleColorGradientStyle = YZTitleColorGradientStyleRGB;

    //遮盖视图
    self.isShowTitleCover = YES;
    self.coverColor = [UIColor colorWithWhite:0.7 alpha:0.4];
    self.coverCornerRadius = 12.f;
    
    //颜色变化
    self.endR = 1;
    self.endG = 130 / 255.0;
    self.endB = 44 / 255.0;
    
    [self setupAllChildsVC];
}

//设置interactivePopGestureRecognizer.enable的属性，这样不响应系统的左滑退出
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)setupAllChildsVC {
    KDChildViewController *vc1 = [[KDChildViewController alloc] init];
    vc1.title = @"精选";
    //将创建的控制器作为本控制器(父控制器)的子控制器
    [self addChildViewController:vc1];
    
    KDChildViewController *vc2 = [[KDChildViewController alloc] init];
    vc2.title = @"电视剧";
    [self addChildViewController:vc2];

    KDChildViewController *vc3 = [[KDChildViewController alloc] init];
    vc3.title = @"电影";
    [self addChildViewController:vc3];
    
    KDChildViewController *vc4 = [[KDChildViewController alloc] init];
    vc4.title = @"综艺";
    [self addChildViewController:vc4];

    KDChildViewController *vc5 = [[KDChildViewController alloc] init];
    vc5.title = @"NBA";
    [self addChildViewController:vc5];

    KDChildViewController *vc6 = [[KDChildViewController alloc] init];
    vc6.title = @"腾讯新闻";
    [self addChildViewController:vc6];

    KDChildViewController *vc7 = [[KDChildViewController alloc] init];
    vc7.title = @"好莱坞";
    [self addChildViewController:vc7];

    KDChildViewController *vc8 = [[KDChildViewController alloc] init];
    vc8.title = @"娱乐";
    [self addChildViewController:vc8];

    KDChildViewController *vc9 = [[KDChildViewController alloc] init];
    vc9.title = @"美剧";
    [self addChildViewController:vc9];

    KDChildViewController *vc10 = [[KDChildViewController alloc] init];
    vc10.title = @"动漫";
    [self addChildViewController:vc10];
}

@end

