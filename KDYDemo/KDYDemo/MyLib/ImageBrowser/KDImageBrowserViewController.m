//
//  KDImageBrowserViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/20.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDImageBrowserViewController.h"
#import "KDLayoutPhotoImageView.h"

@interface KDImageBrowserViewController ()

@end

@implementation KDImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"图片浏览";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *_picImageArray;
    _picImageArray = @[@"pic0.jpg", @"pic1.jpg", @"pic2.jpg", @"pic3.jpg",
                       @"pic4.jpg", @"pic5.jpg", @"pic6.jpg", @"pic7.jpg"];
    
    //创建图片布局视图
    KDLayoutPhotoImageView *photoImageView = [[KDLayoutPhotoImageView alloc] init];
    photoImageView.frame = CGRectMake(30, 200, self.view.size.width, self.view.size.width);
    photoImageView.photosArray = _picImageArray;
    [self.view addSubview:photoImageView];
}

@end
