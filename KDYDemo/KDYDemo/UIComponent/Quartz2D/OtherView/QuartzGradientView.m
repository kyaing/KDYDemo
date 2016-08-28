//
//  QuartzGradientView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/7.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "QuartzGradientView.h"

@implementation QuartzGradientView

/**
 一个渐变是从一个颜色到另外一种颜色的填充
 轴向渐变(线性渐变)：沿着两个端点连接的轴线渐变。与轴向垂直的线上颜色值是一样的。
 径向渐变：也是沿着两个端点连接的轴线渐变，不过路径通常由两个圆定义
 
 CGShadingRef：
    这个不透明数据类型给我们更多的控制权，以确定如何计算每个端点的颜色。
    在创建CGShading对象之前，我们必须创建一个CGFunction对象(CGFunctionRef)，这个对象定义了一个用于计算渐变颜色的函数。
    创建一个CGShading对象时，我们指定其是轴向还是径向，除了计算函数外，我们还需要提供一个颜色空间、起始点和结束点或者是半径，
    这取决于是绘制轴向还是径向渐变。
 
    步骤：
    - 设置CGFunction对象来计算颜色值。
    - 创建径向渐变的CGShading对象。
    - 使用CGShading对象来绘制径向渐变。
    - 释放对象。
 
 CGGradientRef：
    它是CGShading对象的子集，其更易于使用。
    我们不需要提供一个渐变计算函数。当创建一个渐变对象时，我们提供一个位置和颜色的数组。
    创建一个CGGradient对象时，我们需要设置一个颜色空间、位置、和每个位置对应的颜色值。
 
    步骤：
    - 提供一个颜色空间，一个包含两个或更多颜色组件的数组，一个包含两个或多个位置的数组，和两个数组中元素的个数。
    - 调用CGContextDrawLinearGradient或CGContextDrawRadialGradient函数并提供一个上下文、一个CGGradient对象、
        绘制选项和开始结束几何图形来绘制渐变。
    - 不再需要时释放CGGradient对象。
 */

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    //1.CGGradientRef
    //轴向渐变
    //    [self drawLinearGradient:myContext];
    
    //径向渐变
    [self drawRadialGradient:myContext];
    
    //2.CGShadingRef
    //    //径向渐变
    //    myPaintRadialShading(myContext, CGRectMake(0, 300, 200, 200));
    //    
    //    //轴向渐变
    //    myPaintAxialShading(myContext, CGRectMake(0, 320, 200, 200));
}

- (void)drawLinearGradient:(CGContextRef)context {
    //使用RGB颜色空间
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    
    //裁切出一块矩形用于显示，意必须先裁切再调用渐变
    CGContextClipToRect(context, CGRectMake(20, 20, 100, 100));
    
    /**
     指定渐变色：
     - space:颜色空间
     - components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
        如果有三个颜色则这个数组有4*3个元素
     - locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     - count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12] = {
        248.0/255.0, 86.0/255.0,  86.0/255.0,  1,
        249.0/255.0, 127.0/255.0, 127.0/255.0, 1,
        1.0, 1.0, 1.0, 1.0
    };
    CGFloat locations[3] = {0, 0.3, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(spaceRef, compoents, locations, 3);
    
    /**
     绘制线性渐变
     - context:图形上下文
     - gradient:渐变色
     - startPoint:起始位置
     - endPoint:终止位置
     - options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
        kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointMake(10, 10), CGPointMake(100, 100), kCGGradientDrawsAfterEndLocation);
    
    CGColorSpaceRelease(spaceRef);
}

- (void)drawRadialGradient:(CGContextRef)context {
    //使用RGB颜色空间
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    
    /**
     指定渐变色：
     - space:颜色空间
     - components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     - locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     - count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12] = {
        248.0/255.0, 86.0/255.0,  86.0/255.0,  1,
        249.0/255.0, 127.0/255.0, 127.0/255.0, 1,
        1.0, 1.0, 1.0, 1.0
    };
    CGFloat locations[3] = {0, 0.3, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(spaceRef, compoents, locations, 3);
    
    /**
     绘制径向渐变
     - context:图形上下文
     - gradient:渐变色
     - startCenter:起始点位置
     - startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     - endCenter:终点位置（通常和起始点相同，否则会有偏移）
     - endRadius:终点半径（也就是渐变的扩散长度）
     - options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
        kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradient, self.center, 0, self.center, 150, kCGGradientDrawsAfterEndLocation);
    
    CGColorSpaceRelease(spaceRef);
}

static void myCalculateShadingValues (void *info, const CGFloat *in, CGFloat *out) {
    CGFloat v;
    size_t k, components;
    static const CGFloat c[] = {1, 0, .5, 0 };
    
    components = (size_t)info;
    
    v = *in;
    for (k = 0; k < components -1; k++)
        *out++ = c[k] * v;
    *out++ = 1;
}

static CGFunctionRef myGetFunction (CGColorSpaceRef colorspace) {
    size_t numComponents;
    static const CGFloat input_value_range [2] = { 0, 1 };
    static const CGFloat output_value_ranges [8] = { 0, 1, 0, 1, 0, 1, 0, 1 };
    static const CGFunctionCallbacks callbacks = { 0,
        &myCalculateShadingValues,
        NULL };
    
    numComponents = 1 + CGColorSpaceGetNumberOfComponents (colorspace);
    return CGFunctionCreate ((void *) numComponents,
                             1,
                             input_value_range,
                             numComponents,
                             output_value_ranges,
                             &callbacks);
}

void myPaintAxialShading (CGContextRef myContext, CGRect bounds) {
    CGPoint startPoint, endPoint;
    CGAffineTransform myTransform;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;

    startPoint = CGPointMake(0,0.5);
    endPoint = CGPointMake(1,0.5);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFunctionRef myShadingFunction = myGetFunction(colorspace);
    
    CGShadingRef shading = CGShadingCreateAxial (colorspace,
                                    startPoint, endPoint,
                                    myShadingFunction,
                                    false, false);
    
    myTransform = CGAffineTransformMakeScale (width, height);
    CGContextConcatCTM (myContext, myTransform);
    CGContextSaveGState (myContext);
    
    CGContextClipToRect (myContext, CGRectMake(0, 0, 1, 1));
    CGContextSetRGBFillColor (myContext, 1, 1, 1, 1);
    CGContextFillRect (myContext, CGRectMake(0, 0, 1, 1));
    
    CGContextBeginPath (myContext);
    CGContextAddArc (myContext, .5, .5, .3, 0, M_PI_2, 0);
    CGContextClosePath (myContext);
    CGContextClip (myContext);
    
    CGContextDrawShading (myContext, shading);
    CGColorSpaceRelease (colorspace);
    CGShadingRelease (shading);
    CGFunctionRelease (myShadingFunction);
    
    CGContextRestoreGState (myContext);
}

void myPaintRadialShading (CGContextRef myContext, CGRect bounds) {
    CGPoint startPoint, endPoint;
    CGFloat startRadius, endRadius;
    CGAffineTransform myTransform;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    
    startPoint = CGPointMake(0.25, 0.3);
    startRadius = .1;
    endPoint = CGPointMake(.7, 0.7);
    endRadius = .25;
    
    //设置CGFunction对象来计算颜色值
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFunctionRef myShadingFunction = myGetFunction (colorspace);
    
    CGShadingRef shading = CGShadingCreateRadial (colorspace,
                                     startPoint, startRadius,
                                     endPoint, endRadius,
                                     myShadingFunction,
                                     false, false);
    
    myTransform = CGAffineTransformMakeScale (width, height);
    CGContextConcatCTM (myContext, myTransform);
    CGContextSaveGState (myContext);
    
    CGContextClipToRect (myContext, CGRectMake(0, 0, 1, 1));
    CGContextSetRGBFillColor (myContext, 1, 1, 1, 1);
    CGContextFillRect (myContext, CGRectMake(0, 0, 1, 1));
    
    CGContextDrawShading (myContext, shading);
    CGColorSpaceRelease (colorspace);
    CGShadingRelease (shading);
    CGFunctionRelease (myShadingFunction);
    
    CGContextRestoreGState (myContext); 
}

@end

