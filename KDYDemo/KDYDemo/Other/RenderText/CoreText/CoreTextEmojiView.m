//
//  CoreTextEmojiView.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/3.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CoreTextEmojiView.h"

@implementation CoreTextEmojiView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setupEmojiText];
}

/**
 改用CTLineDraw的方式，一行一行的绘制，必然要考虑到行高的计算。
 */
- (void)setupEmojiText {
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
    NSString *textStr = @"我自横刀向天笑，去留肝胆两昆仑。--谭嗣同同学你好啊。This is my first CoreText demo,how are you ?I love three things,the sun,the moon,and you.the sun for the day,the moon for the night,and you forever.😳😊😳😊😳😊😳去年今日此门中，人面桃花相映红。人面不知何处去，桃花依旧笑春风。😳😊😳😊😳😊😳少年不知愁滋味，爱上层楼，爱上层楼，为赋新词强说愁。56321363464.而今识尽愁滋味，欲说还休，欲说还休，却道天凉好个秋。123456，@习大大 ，56321267895434。缺月挂疏桐，漏断人初静。谁见幽人独往来，缥缈孤鸿影。惊起却回头，有恨无人省。捡尽寒枝不肯栖，寂寞沙洲冷。";
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

