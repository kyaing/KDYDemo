//
//  AniOneToViewController.m
//  KDYDemo
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "AniOneToViewController.h"
#import "PingPopTransition.h"

@interface AniOneToViewController ()
@end

@implementation AniOneToViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"AniOneTo";
    self.view.backgroundColor = [UIColor greenColor];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _buttonTwo = [[UIButton alloc] initWithFrame:CGRectMake(width - 80, 100, 60, 60)];
    _buttonTwo.backgroundColor = [UIColor blackColor];
    _buttonTwo.titleLabel.text = @"One";
    _buttonTwo.titleLabel.textColor = [UIColor whiteColor];
    _buttonTwo.layer.cornerRadius = 30;
    _buttonTwo.layer.masksToBounds = YES;
    [_buttonTwo addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonTwo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //让此控制器作为导航栏的代理
    self.navigationController.delegate = self;
}

- (void)popAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        PingPopTransition *ping = [PingPopTransition new];
        return ping;
    }
    
    return nil;
}

@end


