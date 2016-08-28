//
//  CoreTextData.m
//  KDYDemo
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CoreTextData.h"

@implementation CoreTextData

- (void)setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame != ctFrame) {
        if (_ctFrame != nil) {
            CFRelease(_ctFrame);
        }
        
        CFRetain(ctFrame);
        _ctFrame = ctFrame;
    }
}

- (void)dealloc {
    if (_ctFrame != nil) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}

- (void)setImgArray:(NSMutableArray *)imgArray {
    if (_imgArray == imgArray) {
        
    }
}

/**
 *  找到每张图片在绘制时的位置
 */
- (void)fillImgPostion {
    
}

@end

