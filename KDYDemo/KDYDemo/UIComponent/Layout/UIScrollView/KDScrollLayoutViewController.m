//
//  KDScrollLayoutViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/2/24.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDScrollLayoutViewController.h"

@interface KDScrollLayoutViewController ()

@end

@implementation KDScrollLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"布局ScrollView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)setupViews {
    //滚动视图
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.clipsToBounds = NO;
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view).sizeOffset(CGSizeMake(-100, -300));
    }];
    
    //容器视图
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.alpha = 0.5;
    [scrollView addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);  //固定容器视图的宽，为了上下滚动
    }];
    
    //子视图
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [containerView addSubview:redView];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [containerView addSubview:blueView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView).offset(20);
        make.left.right.equalTo(containerView);
        make.height.mas_equalTo(300);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView.mas_bottom).offset(50);
        make.left.right.equalTo(containerView);
        make.bottom.equalTo(containerView).offset(-20);
        make.height.mas_equalTo(100);
    }];
}

@end

