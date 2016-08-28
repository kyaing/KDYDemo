//
//  FrameHeightCellLayout.h
//  KDYDemo
//
//  Created by zhongye on 16/3/17.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellHeightModel.h"

/**
 *  Cell的布局，布局排版应该在后台线程完成
 */
@interface FrameHeightCellLayout : NSObject

/**_textLayout *  总高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  模型
 */
@property (nonatomic, strong) CellHeightModel *model;

/**
 *  文本
 */
@property (nonatomic, strong) YYTextLayout *textLayout;

/**
 *  富文本高度
 */
@property (nonatomic, assign) CGFloat textHeight;

- (instancetype)initWithModel:(CellHeightModel *)model;
- (void)layout;

@end

