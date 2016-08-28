//
//  TextLinePositionModifier.h
//  KDYDemo
//
//  Created by zhongye on 16/3/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文本 Line 位置修改
 *  将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface TextLinePositionModifier : NSObject <YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont  *font;//基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop;//文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom;//文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple;//行距倍数

- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end

