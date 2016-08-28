//
//  CTDisplayView.m
//  KDYDemo
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CTDisplayView.h"

@implementation CTDisplayView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    /** 渲染文本的步骤 */
//    //1 获得上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //2 翻转坐标系
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    
//    //3 创建绘制区域
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.bounds);
//    
//    //4 准备要显示的字符串
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"按照以上原则，我们将`CTDisplayView`中的部分内容拆开。"];
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
//    
//    //5 绘制
//    CTFrameDraw(frame, context);
//    
//    //6 释放
//    CFRelease(framesetter);
//    CFRelease(frame);
//    CFRelease(path);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
}

@end

