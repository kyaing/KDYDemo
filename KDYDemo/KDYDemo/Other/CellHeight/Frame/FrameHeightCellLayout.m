//
//  FrameHeightCellLayout.m
//  KDYDemo
//
//  Created by zhongye on 16/3/17.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "FrameHeightCellLayout.h"
#import "TextLinePositionModifier.h"
#import "StatusHelper.h"

#define kFrameCellTextFont          15
#define kFrameCellModifierTextFont  16
#define kFrameCellEmoticonTextFont  14

#define kPaddingTop     6
#define kPaddingBottom  6

@interface FrameHeightCellLayout ()

@end

@implementation FrameHeightCellLayout

- (instancetype)initWithModel:(CellHeightModel *)model {
    if (self = [super init]) {
        _model = model;
        
        //直接布局
        [self layout];
    }
    
    return self;
}

- (void)layout {
    //布局富文本
    [self _layoutText];
    
    //这里的55，由于是测试，所以是个写死的固定值(文本上的控件+间距)
    _height = _textHeight + 55;
}

- (void)_layoutText{
    _textHeight = 0;
    _textLayout = nil;
    
    //得到加工后的富文本
    NSMutableAttributedString *mutableTextString = @[].mutableCopy;
    mutableTextString = [self _contentWithText:_model.content fontSize:kFrameCellTextFont textColor:RGB(50, 50, 50)];
    
    if (mutableTextString.length == 0) {
        return;
    }
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kScreenWidth - 80, HUGE);
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:mutableTextString];
    if (!_textLayout) {
        return;
    }
    
    //不用Modifier得到行高
    //(显示文本的时候有细微的问题，某些中文看着最后一行像是被切割过一样，有些显示不完整)
    //textHeight = _textLayout.textBoundingSize.height;
    
    //修正文本的显示
    //(利用modifier，就能消除中文底部显示不完整的bug，注意设置paddingTop和paddingBottom的值)
    TextLinePositionModifier *modifier = [TextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kFrameCellModifierTextFont];
    modifier.paddingTop = kPaddingTop;
    modifier.paddingBottom = kPaddingBottom;
    
    //得到文本高度
    _textHeight = [modifier heightForLineCount:_textLayout.rowCount];
}

/**
 *  处理返回的富文本内容
 *
 *  @param text      文本内容
 *  @param fontSize  文本字体大小
 *  @param textColor 文本颜色
 *
 *  @return 富文本
 */
- (NSMutableAttributedString *)_contentWithText:(NSString *)text
                                       fontSize:(CGFloat)fontSize
                                      textColor:(UIColor *)textColor {
    if (!text) {
        return nil;
    }
    
    NSMutableString *textString = text.mutableCopy;
    if (textString.length == 0) {
        return nil;
    }
    
    //注意字体要用"Heiti SC"，否则使用systemFontOfSize:就挤压行间距了
    NSMutableAttributedString *mutableTextString = [[NSMutableAttributedString alloc] initWithString:textString];
    mutableTextString.font = [UIFont fontWithName:@"Heiti SC" size:fontSize];
    mutableTextString.color = textColor;
    
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = UIColorHex(bfdffe);
    
    //匹配@用户名
    NSArray *regexAtResults = [[StatusHelper regexAt] matchesInString:mutableTextString.string options:kNilOptions range:mutableTextString.rangeOfAll];
    for (NSTextCheckingResult *result in regexAtResults) {
        if (result.range.location == NSNotFound && result.range.length <= 1) {
            continue;
        }
        
        if ([mutableTextString attribute:YYTextHighlightAttributeName atIndex:result.range.location] == nil) {
            [mutableTextString setColor:UIColorHex(527ead) range:result.range];
            
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setBackgroundBorder:highlightBorder];
            //数据信息，用于稍后用户点击
            highlight.userInfo = @{@"At" : [mutableTextString.string substringWithRange:NSMakeRange(result.range.location + 1, result.range.length - 1)]};
            [mutableTextString setTextHighlight:highlight range:result.range];
        }
    }
    
    //匹配网址
    NSArray *regexUrlResults = [[StatusHelper regexWeb] matchesInString:mutableTextString.string options:kNilOptions range:mutableTextString.rangeOfAll];
    for (NSTextCheckingResult *result in regexUrlResults) {
        if (result.range.location == NSNotFound && result.range.length <= 1) {
            continue;
        }
        
        if ([mutableTextString attribute:YYTextHighlightAttributeName atIndex:result.range.location] == nil) {
            [mutableTextString setColor:[UIColor redColor] range:result.range];
            
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setBackgroundBorder:highlightBorder];
            //数据信息，用于稍后用户点击
            highlight.userInfo = @{@"Web" : [mutableTextString.string substringWithRange:NSMakeRange(result.range.location, result.range.length)]};
            
            [mutableTextString setTextHighlight:highlight range:result.range];
            
            NSMutableAttributedString *replaceString = [[NSMutableAttributedString alloc] initWithString:@"网址链接"];
            YYTextBackedString *backed = [YYTextBackedString stringWithString:[mutableTextString.string substringWithRange:result.range]];
            [replaceString setTextBackedString:backed range:NSMakeRange(0, replaceString.length)];
            
            //替换网址，###为什么在替换字符串时就Crash了!?
            NSLog(@"%lu, %lu", (unsigned long)result.range.location, (unsigned long)result.range.length);
            //[mutableTextString replaceCharactersInRange:result.range withAttributedString:replaceString];
        }
    }
    
    //匹配[表情]
    NSArray *regexEmoResults = [[StatusHelper regexEmotion] matchesInString:mutableTextString.string options:kNilOptions range:mutableTextString.rangeOfAll];
    NSUInteger emoClipLength = 0;
    for (NSTextCheckingResult *result in regexEmoResults) {
        if (result.range.location == NSNotFound && result.range.length <= 1) {
            continue;
        }
        
        NSRange range = result.range;
        range.location -= emoClipLength;
        
        if ([mutableTextString attribute:YYTextHighlightAttributeName atIndex:range.location]) {
            continue;
        }
        if ([mutableTextString attribute:YYTextAttachmentAttributeName atIndex:range.location]) {
            continue;
        }
        
        NSString *emotionString = [mutableTextString.string substringWithRange:range];
        NSString *imagePath = [StatusHelper emoticonDic][emotionString];
        //NSLog(@"截取出的表情：%@; \n 具体表情所在的路径：%@", emotionString, imagePath);
        
        //        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        //        if (!image) {
        //            continue;
        //        }
        
        UIImage *image = [StatusHelper imageWithPath:imagePath];
        if (!image) {
            continue;
        }
        
        NSAttributedString *emoText = [NSAttributedString attachmentStringWithEmojiImage:image fontSize:kFrameCellEmoticonTextFont];
        [mutableTextString replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length -1;
    }
    
    return mutableTextString;
}

@end

