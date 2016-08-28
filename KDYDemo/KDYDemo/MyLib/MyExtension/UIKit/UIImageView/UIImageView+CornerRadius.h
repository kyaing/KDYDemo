//
//  UIImageView+CornerRadius.h
//  KDYDemo
//
//  Created by zhongye on 16/2/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CornerRadius)

- (UIImage *)ky_addCornerRadiusWithRaidus:(CGFloat)radius
                                     size:(CGSize)size;

@end

@interface UIImageView (CornerRadius)

/**
 *  为UIImageView添加圆角
 *  (注意UIImageView的image不能为空，否则设置不了圆角)
 *
 *  @param radius 圆角半径
 */
- (void)ky_addCornerRadius:(CGFloat)radius;

@end

