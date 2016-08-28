//
//  KDPaintBoardViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDPaintBoardViewController.h"
#import "QuartzPaintView.h"

@interface KDPaintBoardViewController ()
@property (nonatomic, strong) QuartzPaintView *paintView;

@end

@implementation KDPaintBoardViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"自定义画板";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //画板
    self.paintView = [[QuartzPaintView alloc] initWithFrame:self.view.frame];
    self.paintView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.paintView];
}

@end

