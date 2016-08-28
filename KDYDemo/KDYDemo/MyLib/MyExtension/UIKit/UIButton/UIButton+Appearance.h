//
//  UIButton+Appearance.h
//  KDYDemo
//
//  Created by zhongye on 16/2/23.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIButton添加背景色
 */
@interface UIButton (Appearance)

/**
 *  设置按钮背景颜色
 *
 *  @param backgroundColor 背景色
 *  @param state           按钮状态
 */
- (void)ky_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  设置按钮背景图片
 *
 *  @param imageName 图片名称
 */
- (void)ky_setButtonImage:(NSString *)imageName;

/**
 *  设置按钮背景图片
 *
 *  @param imageName 图片名称
 *  @param state     状态
 */
- (void)ky_setButtonImage:(NSString *)imageName forState:(UIControlState)state;

@end

