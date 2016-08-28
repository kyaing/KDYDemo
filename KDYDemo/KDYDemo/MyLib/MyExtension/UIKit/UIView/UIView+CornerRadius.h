//
//  UIView+CornerRadius.h
//  KDYDemo
//
//  Created by zhongye on 16/2/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

/**
 *  为UIView添加圆角
 *
 *  @param radius 圆角半径
 */
- (void)ky_addViewCornerRadius:(CGFloat)radius;

/**
 *  为UIView添加圆角
 *  (注意这里超出圆角的部分依然会显示，那么要把UIView的背景色设置为clearColor, 同时要设置bgColor)
 *
 *  @param radius      圆角半径
 *  @param borderWidth 边宽
 *  @param bgColor     内部的背景颜色
 *  @param borderColor 边的颜色
 */
- (void)ky_addViewCornerRadius:(CGFloat)radius
                   borderWidth:(CGFloat)borderWidth
                       bgColor:(UIColor *)bgColor
                   borderColor:(UIColor *)borderColor;

@end

