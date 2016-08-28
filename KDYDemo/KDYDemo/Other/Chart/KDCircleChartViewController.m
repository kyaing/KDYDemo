//
//  KDCicleChartViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/1.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDCircleChartViewController.h"
#import "CircleChartView.h"

@interface KDCircleChartViewController ()

@end

@implementation KDCircleChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Circle Chart";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Circle Chart
    CircleChartView *circleView = [[CircleChartView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 200) total:@100 current:@60 clockwise:YES];
    circleView.backgroundColor = [UIColor clearColor];
    [circleView setStrokeColor:[UIColor clearColor]];
    [circleView setStrokeColorGradientStart:[UIColor blueColor]];
    [circleView strokeChart];
    
    [self.view addSubview:circleView];
}

@end

