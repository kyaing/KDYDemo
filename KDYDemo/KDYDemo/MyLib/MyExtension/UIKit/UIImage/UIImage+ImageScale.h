//
//  UIImage+ImageScale.h
//  KDYDemo
//
//  Created by zhongye on 16/2/17.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：截取部分图片、等比例绽放图片

#import <UIKit/UIKit.h>

@interface UIImage (ImageScale)

- (UIImage *)kd_getSubImage:(CGRect)rect;
- (UIImage *)kd_scaleToSize:(CGSize)size;

@end
