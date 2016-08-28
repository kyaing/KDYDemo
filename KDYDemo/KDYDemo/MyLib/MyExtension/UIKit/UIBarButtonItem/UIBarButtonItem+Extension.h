//
//  UIBarButtonItem+Extension.h
//  GaGaHi
//
//  Created by zhongyekeji on 15/7/27.
//  Copyright (c) 2015年 Zonyet. All rights reserved.
//
//  描述：导航按钮的分类

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  @brief  返回自定义的导航按钮
 *
 *  @param imageName  普通图片
 *  @param hightImage 选中图片
 *  @param target     target
 *  @param action     方法
 *
 *  @return 自定义的导航按钮
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                        hightImageName:(NSString *)hightImage
                                target:(id)target
                                action:(SEL)action;

@end
