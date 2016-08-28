//
//  QuartzPolygonView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/6.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "QuartzPolygonView.h"

@implementation QuartzPolygonView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(contextRef, 1.0, 0, 0, 1.0);
    CGContextSetRGBFillColor(contextRef, 0, 1.0, 0, 1.0);
    CGContextSetLineWidth(contextRef, 2.0);
    
    //1.正方形
    CGContextAddRect(contextRef, CGRectMake(30, 30, 60, 60));
    CGContextStrokePath(contextRef);
    
    CGContextStrokeRect(contextRef, CGRectMake(30, 120, 60, 60));
    CGContextStrokeRectWithWidth(contextRef, CGRectMake(30, 210, 60, 60), 10);
    CGContextSaveGState(contextRef);
    
    CGContextSetRGBStrokeColor(contextRef, 0, 1, 0, 1.0);
    CGContextStrokeRectWithWidth(contextRef, CGRectMake(30, 210, 60, 60), 2);
    CGContextStrokePath(contextRef);
    
    //2.多个正方形
    CGRect rects[] = {
        CGRectMake(120.0, 30.0, 60.0, 60.0),
        CGRectMake(120.0, 120.0, 60.0, 60.0),
        CGRectMake(120.0, 210.0, 60.0, 60.0),
    };
    CGContextAddRects(contextRef, rects, sizeof(rects)/sizeof(rects[0]));
    CGContextStrokePath(contextRef);  //绘制路径
    
    //3.五角形
    CGPoint center;
    center = CGPointMake(90.0, 350.0);
    CGContextMoveToPoint(contextRef, center.x, center.y + 60.0);
    for (int i = 1; i < 5; ++i) {
        CGFloat x = 60.0 * sinf(i * 4.0 * M_PI / 5.0);
        CGFloat y = 60.0 * cosf(i * 4.0 * M_PI / 5.0);
        CGContextSetRGBStrokeColor(contextRef, 0, 0, 1, 1.0);
        CGContextAddLineToPoint(contextRef, center.x + x, center.y + y);
    }
    CGContextClosePath(contextRef);
    
    //4.六边形
    center = CGPointMake(210.0, 350.0);
    CGContextMoveToPoint(contextRef, center.x, center.y + 60.0);
    for (int i = 1; i < 6; ++i) {
        CGFloat x = 60.0 * sinf(i * 2.0 * M_PI / 6.0);
        CGFloat y = 60.0 * cosf(i * 2.0 * M_PI / 6.0);
        CGContextAddLineToPoint(contextRef, center.x + x, center.y + y);
    }
    CGContextClosePath(contextRef);
    /*
     CGPathDrawingMode是填充方式,枚举类型
     - kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     - kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     - kCGPathStroke:只有边框
     - kCGPathFillStroke：既有边框又有填充
     - kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(contextRef, kCGPathEOFillStroke);
}

@end

