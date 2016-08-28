//
//  UIButton+Appearance.m
//  KDYDemo
//
//  Created by zhongye on 16/2/23.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UIButton+Appearance.h"

@implementation UIButton (Appearance)

- (void)ky_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1.f, 1.f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)ky_setButtonImage:(NSString *)imageName {
    [self ky_setButtonImage:imageName forState:UIControlStateNormal];
}

- (void)ky_setButtonImage:(NSString *)imageName forState:(UIControlState)state {
    [self setImage:[UIImage imageNamed:imageName] forState:state];
}

@end

