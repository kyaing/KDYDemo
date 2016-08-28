//
//  QuartzLineView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/5.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "QuartzLineView.h"

@implementation QuartzLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //1.一条直线
    CGContextSetRGBStrokeColor(contextRef, 10/255.0, 10/255.0, 10/255.0, 1.0);
    CGContextSetLineWidth(contextRef, 2.0);
    
    CGContextMoveToPoint(contextRef, 10, 100);
    CGContextAddLineToPoint(contextRef, 50, 200);
    CGContextStrokePath(contextRef);  //描线
    
    //2.多条连接的直线
    CGPoint addLines[] = {
        CGPointMake(100, 100),
        CGPointMake(120, 200),
        CGPointMake(200, 70),
        CGPointMake(300, 200)
    };
    CGContextSetRGBStrokeColor(contextRef, 155/255.0, 10/255.0, 132/255.0, 1.0);
    CGContextAddLines(contextRef, addLines, sizeof(addLines)/sizeof(addLines[0]));
    CGContextStrokePath(contextRef);
    
    //3.多条非连接直线
    CGPoint strokeSegement[] = {
        CGPointMake(10.0, 250.0),
        CGPointMake(70.0, 220.0),
        CGPointMake(130.0, 250.0),
        CGPointMake(190.0, 220.0),
        CGPointMake(250.0, 250.0),
        CGPointMake(310.0, 220.0),
    };
    CGContextSetRGBStrokeColor(contextRef, 200/255.0, 100/255.0, 132/255.0, 1.0);
    CGContextStrokeLineSegments(contextRef, strokeSegement, sizeof(strokeSegement)/sizeof(strokeSegement[0]));
    
    //4.虚线
    CGFloat lengths[] = {10, 5};
    CGContextSetLineDash(contextRef, 0, lengths, 2);
    
    CGContextMoveToPoint(contextRef, 10.0, 300.0);
    CGContextAddLineToPoint(contextRef, 310.0, 300.0);
    CGContextMoveToPoint(contextRef, 160.0, 320.0);
    CGContextAddLineToPoint(contextRef, 160.0, 400.0);
    CGContextAddRect(contextRef, CGRectMake(10.0, 320.0, 100.0, 100.0));
    CGContextAddEllipseInRect(contextRef, CGRectMake(210.0, 320.0, 100.0, 100.0));
    CGContextSetLineWidth(contextRef, 2.0);
    CGContextStrokePath(contextRef);
}

@end

