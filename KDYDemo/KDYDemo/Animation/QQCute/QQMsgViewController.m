//
//  QQMsgViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/11/26.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "QQMsgViewController.h"
#import "QQCuteView.h"

@interface QQMsgViewController ()

@end

@implementation QQMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"QQ未读消息拖拽";
    self.view.backgroundColor = [UIColor whiteColor];
    
    QQCuteView *cuteView = [[QQCuteView alloc] initWithPoint:CGPointMake(25, [UIScreen mainScreen].bounds.size.height - 65) superView:self.view];
    cuteView.bubuleWidth = 35;
    cuteView.bubuleColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
    [cuteView setUp];
    cuteView.backgroundColor = [UIColor redColor];
    
    cuteView.bubuleLabel.text = @"13";
}

@end

