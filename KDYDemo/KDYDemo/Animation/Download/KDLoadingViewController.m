//
//  KDLoadingViewController.m
//  KDYDemo
//
//  Created by kaideyi on 15/12/1.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDLoadingViewController.h"
#import "UIImageView+WebCache.h"
#import "CircleLoaderView.h"

@interface KDLoadingViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation KDLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"圆形图片加载";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建圆形加载视图
    CircleLoaderView *circleLoaderView = [[CircleLoaderView alloc] initWithFrame:CGRectZero];
    circleLoaderView.frame = CGRectMake((self.view.bounds.size.width - 100)/2, (self.view.bounds.size.height - 100)/2, 100, 100);
    [self.view addSubview:circleLoaderView];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.raywenderlich.com/wp-content/uploads/2015/02/mac-glasses.jpeg"];
    [_imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //下载的进度来更新圆环的进度
        float progress = (receivedSize * 0.1) / (expectedSize * 0.1);
        if (progress >= 0.f) {
            circleLoaderView.progress = progress;
            NSLog(@"progress = %f", progress);
        }
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //#=>为什么不能将图片删除？
    _imageView.image = nil;
    [_imageView removeFromSuperview];
}

@end

