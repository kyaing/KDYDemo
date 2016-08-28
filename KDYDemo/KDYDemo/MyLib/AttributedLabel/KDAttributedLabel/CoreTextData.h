//
//  CoreTextData.h
//  KDYDemo
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParse.h"

/**
 *  数据模型
 */
@interface CoreTextData : NSObject

@property (nonatomic, assign) CTFrameRef ctFrame;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSMutableArray *imgArray;
 
@end

