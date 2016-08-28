//
//  KDXMViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/11.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDXMViewController.h"
#import "KDChildViewController.h"

@interface KDXMViewController ()

@end

@implementation KDXMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"喜马拉雅";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isShowUnderLine = YES;
    self.titleScrollViewColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha: 1.0];
    
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
    vc2.title = @"分类";
    [self addChildViewController:vc2];
    
    KDChildViewController *vc3 = [[KDChildViewController alloc] init];
    vc3.title = @"直播";
    [self addChildViewController:vc3];
    
    KDChildViewController *vc4 = [[KDChildViewController alloc] init];
    vc4.title = @"榜单";
    [self addChildViewController:vc4];
    
    KDChildViewController *vc5 = [[KDChildViewController alloc] init];
    vc5.title = @"主播";
    [self addChildViewController:vc5];
}

@end

