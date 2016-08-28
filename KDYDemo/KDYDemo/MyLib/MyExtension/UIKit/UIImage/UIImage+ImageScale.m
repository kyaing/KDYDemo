//
//  UIImage+ImageScale.m
//  KDYDemo
//
//  Created by zhongye on 16/2/17.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UIImage+ImageScale.h"

@implementation UIImage (ImageScale)

- (UIImage *)kd_getSubImage:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextDrawImage(content, smallBounds, subImageRef);
    UIImage *subImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    return subImage;
}

- (UIImage *)kd_scaleToSize:(CGSize)size {
    return nil;
}

@end

