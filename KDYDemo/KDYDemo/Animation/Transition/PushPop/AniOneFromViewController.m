//
//  AniOneFromViewController.m
//  KDYDemo
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "AniOneFromViewController.h"
#import "AniOneToViewController.h"
#import "PingPushTransition.h"

@interface AniOneFromViewController ()

@end

@implementation AniOneFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"AniOneFrom";
    self.view.backgroundColor = [UIColor orangeColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _buttonOne = [[UIButton alloc] initWithFrame:CGRectMake(width - 80, 100, 60, 60)];
    _buttonOne.backgroundColor = [UIColor blackColor];
    _buttonOne.titleLabel.text = @"One";
    _buttonOne.titleLabel.textColor = [UIColor whiteColor];
    _buttonOne.layer.cornerRadius = 30;
    _buttonOne.layer.masksToBounds = YES;
    [_buttonOne addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonOne];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

- (void)pushAction:(UIButton *)button {
    [self.navigationController pushViewController:[AniOneToViewController new] animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        PingPushTransition *ping = [PingPushTransition new];
        return ping;
    }
    
    return nil;
}

@end


