//
//  CoreTextView.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextView.h"

@implementation CoreTextView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //基础的文本展示
    [self setupText];
}

- (void)setupText {
    //1.获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //转换前的坐标：[a, b, c, d, tx, ty]
    NSLog(@"转换前的坐标：%@", NSStringFromCGAffineTransform(CGContextGetCTM(contextRef)));
    
    //2.转换坐标系，CoreText的原点在左下角，UIKit原点左上角
    CGContextSetTextMatrix(contextRef, CGAffineTransformIdentity);
    CGContextConcatCTM(contextRef, CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height));
    NSLog(@"转换后的坐标：%@", NSStringFromCGAffineTransform(CGContextGetCTM(contextRef)));
    
    //3.创建绘制区域，可以对path进行个性化裁剪以改变显示区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    //4.创建需要绘制的文字
    NSString *textStr = @"在iOS 8及之后的版本中，使用HealthKit构建的应用可以利用从健康应用中获取的数据为用户提供更强大、更完整的健康及健身服务。在用户允许的情况下，应用可以通过HealthKit来读写健康应用(用户健康相关数据的存储中心)中的数据。";
    NSMutableAttributedString *attTextString = [[NSMutableAttributedString alloc] initWithString:textStr];
    
    //设置字体大小和字体颜色
    [attTextString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
    [attTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 10)];
    [attTextString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 4)];
    
    //设置行距等样式
    CGFloat lineSpace = 5;
    CGFloat lineSpaceMax = 10;
    CGFloat lineSpaceMin = 2;
    const CFIndex kNumberOfSettings = 3;
    
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpaceMax},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpaceMin}
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    [attTextString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)theParagraphRef range:NSMakeRange(0, attTextString.length)];
    [attTextString addAttribute:NSParagraphStyleAttributeName value:(__bridge id)(theParagraphRef) range:NSMakeRange(0, attTextString.length)];
    CFRelease(theParagraphRef);
    
    //5.根据NSMutableAttributedSting生成CTFramesetterRef
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attTextString);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attTextString.length), path, NULL);
    
    //6.绘制除图片以外的部分
    CTFrameDraw(ctFrame, contextRef);
    
    //7.内存管理，ARC不能管理CF开头的对象，需要我们自己手动释放内存
    CFRelease(path);
    CFRelease(framesetter);
    CFRelease(ctFrame);
}

@end

