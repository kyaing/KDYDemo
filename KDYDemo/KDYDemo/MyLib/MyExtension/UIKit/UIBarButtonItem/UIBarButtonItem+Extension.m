//
//  UIBarButtonItem+Extension.m
//  GaGaHi
//
//  Created by zhongyekeji on 15/7/27.
//  Copyright (c) 2015年 Zonyet. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                        hightImageName:(NSString *)hightImage
                                target:(id)target
                                action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    
    //监听按钮事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //设置按钮的尺寸是当前图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    //返回自定义的导航按钮
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end


