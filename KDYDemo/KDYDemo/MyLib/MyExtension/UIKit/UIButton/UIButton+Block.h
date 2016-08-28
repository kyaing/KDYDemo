//
//  UIButton+Block.h
//  KDYDemo
//
//  Created by zhongye on 16/2/23.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock) (NSInteger tag);

/**
 *  UIButton的点击事件
 */
@interface UIButton (Block)

/**
 *  尝试在Category中加入属性
 */
@property (nonatomic, copy) NSString *myString;

/**
 *  用block的形式改写UIButton的点击事件
 *
 *  @param actionBlock ActionBlock
 */
- (void)ky_addTargetAction:(ActionBlock)actionBlock;

@end

