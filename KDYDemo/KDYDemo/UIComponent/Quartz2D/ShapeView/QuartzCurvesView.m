//
//  QuartzCurvesView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/5.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "QuartzCurvesView.h"

@implementation QuartzCurvesView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //设置线颜色宽度
    CGContextSetRGBStrokeColor(contextRef, 0, 0, 0, 1.0);
    CGContextSetRGBFillColor(contextRef, 0, 0, 1, 1.0);
    CGContextSetLineWidth(contextRef, 2.0);
    
    //1.圆弧
    /**
     添加弧形对象：
     - x:中心点x坐标
     - y:中心点y坐标
     - radius:半径
     - startAngle:起始弧度
     - endAngle:终止弧度
     - closewise:是否逆时针绘制，0则顺时针绘制
     */
    CGContextAddArc(contextRef, 150, 60, 30, 0, M_PI/2.0, false);
    CGContextStrokePath(contextRef);
    
    CGContextAddArc(contextRef, 150, 60, 30, 3.0*M_PI/2, M_PI, true);
    CGContextStrokePath(contextRef);
    
    //2.内切圆描边
    CGContextAddEllipseInRect(contextRef, CGRectMake(30, 30, 60, 60));
    CGContextStrokePath(contextRef);
    
    //3.填充圆
    CGContextFillEllipseInRect(contextRef, CGRectMake(30, 100, 60, 60));
    CGContextStrokePath(contextRef);
    
    //4.通过直线无限延伸，可确定一段弧
    CGPoint p[3] = {
        CGPointMake(210.0, 30.0),
        CGPointMake(210.0, 60.0),
        CGPointMake(240.0, 60.0),
    };
    CGContextMoveToPoint(contextRef, p[0].x, p[0].y);
    CGContextAddArcToPoint(contextRef, p[1].x, p[1].y, p[2].x, p[2].y, 30);
    CGContextStrokePath(contextRef);
    CGContextSetRGBStrokeColor(contextRef, 1.0, 0.0, 0.0, 1.0);
    CGContextAddLines(contextRef, p, sizeof(p)/sizeof(p[0]));
    CGContextStrokePath(contextRef);

    //5.带有圆弧的正方形
    CGRect rrect = CGRectMake(210.0, 100.0, 60.0, 60.0);
    CGFloat radius = 10.0;
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(contextRef, minx, midy);
    CGContextAddArcToPoint(contextRef, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(contextRef, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(contextRef, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(contextRef, minx, maxy, minx, midy, radius);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    //6.二次曲线
    CGContextMoveToPoint(contextRef, 100, 200);
    CGContextAddQuadCurveToPoint(contextRef, 190, 210, 120, 290);  //控制点和终点
    CGContextStrokePath(contextRef);
    
    //7.三次曲线
    CGContextMoveToPoint(contextRef, 200, 200);
    //两个控制点(这个控制点怎么确定，得用画图工具得到最优)和一个终点
    CGContextAddCurveToPoint(contextRef, 250, 350, 350, 100, 300, 300);
    CGContextStrokePath(contextRef);
    
    //8.带有圆角的三角形
    CGPoint points[] = {
        CGPointMake(50, 300),
        CGPointMake(100, 300),   //圆弧起点
        CGPointMake(110, 310),   //圆弧终点
        CGPointMake(110, 360)
    };
    CGContextAddLines(contextRef, points, sizeof(points)/sizeof(points[0]));
    CGContextClosePath(contextRef);
    CGContextFillPath(contextRef);
    
    CGContextMoveToPoint(contextRef, 100, 300);
    CGContextAddQuadCurveToPoint(contextRef, 60, 300, 110, 310);
    CGContextStrokePath(contextRef);
    
    //#warning 没有做好
    //9.一段连续的点连成的曲线
    //    CGContextSetRGBStrokeColor(contextRef, 0, 0, 0, 1.0);
    //    CGContextMoveToPoint(contextRef, 20, 400);
    //    CGContextAddLineToPoint(contextRef, kScreenWidth-20, 400);
    //    CGContextStrokePath(contextRef);
    //    
    //    CGPoint points[] = {
    //        CGPointMake(30, 380),
    //        CGPointMake(40, 360),
    //        CGPointMake(50, 340),
    //        CGPointMake(60, 350),
    //        CGPointMake(70, 390),
    //        CGPointMake(80, 400),
    //        CGPointMake(90, 330)
    //    };
    //    CGContextAddLines(contextRef, points, sizeof(points)/sizeof(points[0]));
    //    CGContextStrokePath(contextRef);
}

@end

