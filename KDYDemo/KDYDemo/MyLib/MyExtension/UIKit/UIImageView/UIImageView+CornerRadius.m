//
//  UIImageView+CornerRadius.m
//  KDYDemo
//
//  Created by zhongye on 16/2/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UIImageView+CornerRadius.h"

@implementation UIImage (CornerRadius)

- (UIImage *)ky_addCornerRadiusWithRaidus:(CGFloat)radius size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath;
    CGContextAddPath(context, path);
    CGContextClip(context);  //对UIImageView的圆角处理采用CGContextClip裁剪的方式
    
    [self drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation UIImageView (CornerRadius)

- (void)ky_addCornerRadius:(CGFloat)radius {
    self.image = [self.image ky_addCornerRadiusWithRaidus:radius size:self.bounds.size];
}

@end

