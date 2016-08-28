//
//  UIView+CornerRadius.m
//  KDYDemo
//
//  Created by zhongye on 16/2/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)

- (void)ky_addViewCornerRadius:(CGFloat)radius {
    [self ky_addViewCornerRadius:radius
                        borderWidth:1
                            bgColor:[UIColor clearColor]
                        borderColor:[UIColor blackColor]];
}

- (void)ky_addViewCornerRadius:(CGFloat)radius
                borderWidth:(CGFloat)borderWidth
                    bgColor:(UIColor *)bgColor
                borderColor:(UIColor *)borderColor {
    
    UIImage *image = [self addRounderCornerRadius:radius
                                      borderWidth:borderWidth
                                          bgColor:bgColor
                                      borderColor:borderColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    //将生成的UIImageView插入到UIView之下
    [self insertSubview:imageView atIndex:0];
}

- (UIImage *)addRounderCornerRadius:(CGFloat)radius
                     borderWidth:(CGFloat)borderWidth
                         bgColor:(UIColor *)bgColor
                     borderColor:(UIColor *)borderColor {
    CGSize size = CGSizeMake(self.bounds.size.width, self.bounds.size.width);
    CGFloat halfBorderWidth = borderWidth / 2;
    CGFloat width = size.width, height = size.height;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth);
    
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

