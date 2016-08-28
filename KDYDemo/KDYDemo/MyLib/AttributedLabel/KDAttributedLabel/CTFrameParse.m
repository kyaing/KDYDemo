//
//  CTFrameParse.m
//  KDYDemo
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CTFrameParse.h"
#import "CoreTextData.h"

@implementation CTFrameParse

#pragma mark - Pravite Methods
+ (NSDictionary *)attributesWithConfig:(CTFrameParseConfig *)config {
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    UIColor *textColor = config.textColor;
    
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing }
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dic[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dic[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    
    return dic;
}

+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter config:(CTFrameParseConfig *)config height:(CGFloat)height {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    return frame;
}

+ (NSAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict config:(CTFrameParseConfig *)config {
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(dict));
    
    //使用OXFFFC作为占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *spaceString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)spaceString, CFRangeMake(0, 1),
                                   kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    
    return spaceString;
}

static CGFloat ascentCallback(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref) {
    return 0;
}

static CGFloat widthCallback(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}

#pragma mark - Public Methods
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParseConfig *)config {
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *contentString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    //创建CTFramesetterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)contentString);
    
    //获得要绘制区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    //生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    //将生成好的CTFrameRef实例和计算好绘制的高度保存到CoreTextData中
    CoreTextData *data = [[CoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    
    //释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    
    return data;
}

+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParseConfig *)config {
    return nil;
}

@end

