//
//  CTFrameParseConfig.m
//  KDYDemo
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CTFrameParseConfig.h"

@implementation CTFrameParseConfig

- (instancetype)init {
    if (self = [super init]) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = RGB(108, 108, 108);
    }
    
    return self;
}

@end

