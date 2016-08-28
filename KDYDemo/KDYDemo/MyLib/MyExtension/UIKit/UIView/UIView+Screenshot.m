//
//  UIView+Screenshot.m
//  KDYDemo
//
//  Created by zhongye on 16/2/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UIView+Screenshot.h"

@implementation UIView (Screenshot)

- (UIImage *)ky_screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    //iOS7之后的版本
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
        
    } else {  //iOS7之前的版本
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

@end

