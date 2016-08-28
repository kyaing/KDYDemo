//
//  QuartzCTMView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "QuartzCTMView.h"

@implementation QuartzCTMView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /**
     在弄清形变之前我们要清楚图形上下文的坐标原点，因为无论是位移还是旋转都是相对于坐标原点进行的，
     注意在设置图形上下文形变之前一定要注意保存上下文的初始状态，在使用完之后进行恢复。
     否则在处理多个图形形变的时候很容易弄不清楚到底是基于怎样的坐标系进行绘图，容易找不到原点。
     */
    CGContextSaveGState(context);
    
    //图形上下文形变
    CGContextTranslateCTM(context, 100, 0);  //平移
    CGContextScaleCTM(context, 0.8, 0.8);    //缩放
    CGContextRotateCTM(context, M_PI_4/4);   //旋转
    
    UIImage *image = [UIImage imageNamed:@"startpage"];
    [image drawInRect:CGRectMake(0, 50, 240, 300)];
    
    CGContextRestoreGState(context);
}

@end
