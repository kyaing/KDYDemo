//
//  ZYNavigationController.m
//  GaGaHi
//
//  Created by zhongyekeji on 15/7/27.
//  Copyright (c) 2015年 Zonyet. All rights reserved.
//

#import "ZYNavigationController.h"

@interface ZYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZYNavigationController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.barTintColor = [UIColor colorWithWhite:0.2 alpha:0.5];
}

/**
 *  当第一次使用这个类的时候调用一次
 */
+ (void)initialize {
    /** 通过appearance外表，能够一次性地设置整个项目的UIBarButtonItem的样式 */
    UIBarButtonItem *barAppearance = [UIBarButtonItem appearance];
    
    //设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barAppearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置选择状态的文字属性
    NSMutableDictionary *hightTextAttrs = [NSMutableDictionary dictionary];
    hightTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    hightTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];;
    [barAppearance setTitleTextAttributes:hightTextAttrs forState:UIControlStateHighlighted];
    
    //设置不可用状态的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barAppearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /** 修改导航栏的appearance */
    UINavigationBar *naviAppearance = [UINavigationBar appearance];
    [naviAppearance setTintColor:[UIColor whiteColor]];
    [naviAppearance setBackgroundImage:[UIImage imageNamed:@"main_background"] forBarMetrics:UIBarMetricsDefault];
    [naviAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                             NSFontAttributeName:[UIFont systemFontOfSize:18.5]}];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Private Methods
/**
 *  可以拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //当栈底内有控制器，才隐藏tabbar，并且添加统一的按钮
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"main_back" hightImageName:@"main_back" target:self action:@selector(backAction)];
    }
    
    [super pushViewController:viewController animated:animated];
}

/**
 *  返回操作
 */
- (void)backAction {
    [self popViewControllerAnimated:YES];
}

@end

