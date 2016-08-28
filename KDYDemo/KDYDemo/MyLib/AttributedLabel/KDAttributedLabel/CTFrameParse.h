//
//  CTFrameParse.h
//  KDYDemo
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParseConfig.h"

/**
 *  排版类
 */
@class CoreTextData;
@interface CTFrameParse : NSObject

+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParseConfig *)config;

+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParseConfig *)config;

@end

