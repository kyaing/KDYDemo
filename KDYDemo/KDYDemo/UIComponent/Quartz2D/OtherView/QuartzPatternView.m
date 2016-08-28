//
//  QuartzPatternView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/6.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "QuartzPatternView.h"

@implementation QuartzPatternView

#define TILE_SIZE 10

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    //设备无关的颜色空间
    CGColorSpaceRef rgbSpace = CGColorSpaceCreateDeviceRGB();
    //模式填充颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(rgbSpace);
    //将填充色颜色空间设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    //填充模式回调函数结构体
    CGPatternCallbacks callback={0,&drawTile,NULL};
    /*
     填充模式
     info://传递给callback的参数
     bounds:瓷砖大小
     matrix:形变
     xStep:瓷砖横向间距
     yStep:瓷砖纵向间距
     tiling:贴砖的方法（瓷砖摆放的方式）
     isClored:绘制的瓷砖是否已经指定了颜色（对于无颜色瓷砖此处指定位false）
     callbacks:回调函数
     */
    CGPatternRef pattern = CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity, 2*TILE_SIZE + 5, 2*TILE_SIZE + 5, kCGPatternTilingNoDistortion, false, &callback);
    
    CGFloat components[]={254.0/255.0,52.0/255.0,90.0/255.0,1.0};
    //注意最后一个参数对于无颜色填充模式指定为当前颜色空间颜色数据
    CGContextSetFillPattern(context, pattern, components);
    //    CGContextSetStrokePattern(context, pattern, components);
    UIRectFill(CGRectMake(10, 10, 320, 568));
    
    CGColorSpaceRelease(rgbSpace);
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
}

void drawTile(void *info,CGContextRef context) {
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}

@end

