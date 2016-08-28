//
//  KDLoadingViewController.h
//  KDYDemo
//
//  Created by kaideyi on 15/12/1.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：利用CAShapeLayer实现圆形的加载动画(UIBezierPath+CAShapeLayer)

/**
 思路：
    首先要画一个圆形进度指示器，然后根据下载进度来更新它；
    接着通过扩展的圆形窗口来显示下载的图片。
 */

#import <UIKit/UIKit.h>

@interface KDLoadingViewController : UIViewController

@end

