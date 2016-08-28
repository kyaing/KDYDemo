//
//  TestConvertViewController.m
//  KDYDemo
//
//  Created by kaideyi on 16/8/27.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "TestConvertViewController.h"

@interface TestConvertViewController ()

@end

@implementation TestConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self layoutConvert];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"bgView frame = %@", NSStringFromCGRect(self.bgView.frame));
}

- (void)layoutConvert {
    self.bgViewTopConstraint.constant    = ConvertLayoutConstraint(490);
    self.bgViewLeftConstraint.constant   = ConvertLayoutConstraint(154);
    self.bgViewRightConstraint.constant  = ConvertLayoutConstraint(154);
    self.bgViewHeightConstraint.constant = ConvertLayoutConstraint(1092);
}

@end

