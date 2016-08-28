//
//  KDJRViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/11.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDJRViewController.h"
#import "KDChildViewController.h"

@interface KDJRViewController ()

@end

@implementation KDJRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"今日头条";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleScrollViewColor = [UIColor colorWithRed:156/255.0 green: 156/255.0 blue: 156/255.0 alpha: 1.0];
    self.isShowTitleScale = YES;
    self.titleScale = 1.2;
    
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
    vc1.title = @"推荐";
    //将创建的控制器作为本控制器(父控制器)的子控制器
    [self addChildViewController:vc1];
    
    KDChildViewController *vc2 = [[KDChildViewController alloc] init];
    vc2.title = @"热点";
    [self addChildViewController:vc2];
    
    KDChildViewController *vc3 = [[KDChildViewController alloc] init];
    vc3.title = @"郑州";
    [self addChildViewController:vc3];
    
    KDChildViewController *vc4 = [[KDChildViewController alloc] init];
    vc4.title = @"视频";
    [self addChildViewController:vc4];
    
    KDChildViewController *vc5 = [[KDChildViewController alloc] init];
    vc5.title = @"订阅";
    [self addChildViewController:vc5];
    
    KDChildViewController *vc6 = [[KDChildViewController alloc] init];
    vc6.title = @"娱乐";
    [self addChildViewController:vc6];
    
    KDChildViewController *vc7 = [[KDChildViewController alloc] init];
    vc7.title = @"科技";
    [self addChildViewController:vc7];
    
    KDChildViewController *vc8 = [[KDChildViewController alloc] init];
    vc8.title = @"汽车";
    [self addChildViewController:vc8];
    
    KDChildViewController *vc9 = [[KDChildViewController alloc] init];
    vc9.title = @"体育";
    [self addChildViewController:vc9];
    
    KDChildViewController *vc10 = [[KDChildViewController alloc] init];
    vc10.title = @"财经";
    [self addChildViewController:vc10];
}

@end

