//
//  QuartzImageView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/6.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "QuartzImageView.h"

@implementation QuartzImageView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //1.图片
    UIImage *image = [UIImage imageNamed:@"Demo"];
    CGContextDrawImage(contextRef, CGRectMake(20, 20, 40, 40), image.CGImage);
    
    //2.普通阴影
    /**
     阴影的三个属性：
     - x偏移值，用于指定阴影相对于图片在水平方向上的偏移值。
     - y偏移值，用于指定阴影相对于图片在竖直方向上的偏移值。
     - 模糊(blur)值，用于指定图像是有一个硬边
     
     绘制阴影步骤：
     - 保存图形状态
     - 调用函数CGContextSetShadow，传递相应的值
     - 使用阴影绘制所有的对象
     - 恢复图形状态
     */
    CGContextSaveGState(contextRef);
    CGSize offset = CGSizeMake(-10, 10);  //阴影向左偏
    CGContextSetShadow(contextRef, offset, 5);
    
    CGContextSetRGBFillColor(contextRef, 1, 0, 0, 1.0);
    CGContextFillRect(contextRef, CGRectMake(120, 20, 100, 100));
    
    CGContextSaveGState(contextRef);
    CGSize offsetRigth = CGSizeMake(10, 10);  //阴影向右偏
    CGContextSetShadow(contextRef, offsetRigth, 1);
    
    CGContextSetRGBFillColor(contextRef, 0, 1, 0, 1.0);
    CGContextFillRect(contextRef, CGRectMake(240, 20, 100, 100));
    CGContextRestoreGState(contextRef);
    
    //3.彩色阴影
    /**
     绘制阴影步骤：
     - 保存图形状态
     - 创建一个CGColorSpace对象，确保Quartz能正确地解析阴影颜色
     - 创建一个CGColor对象来指定阴影的颜色
     - 调用CGContextSetShadowWithColor，并传递相应的值
     - 使用阴影绘制所有的对象
     - 恢复图形状态
     */
    CGFloat colors[] = {1, 0, 0, 0.6};
    CGContextSaveGState(contextRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpace, colors);
    CGContextSetShadowWithColor(contextRef, offsetRigth, 5, color);
    
    CGContextSetRGBFillColor(contextRef, 0, 0, 1, 1.0);
    CGContextFillRect(contextRef, CGRectMake(20, 150, 100, 100));
    CGContextRestoreGState(contextRef);
    
    CGColorRelease(color);
    CGColorSpaceRelease(colorSpace);
    
    //4.
}

@end

