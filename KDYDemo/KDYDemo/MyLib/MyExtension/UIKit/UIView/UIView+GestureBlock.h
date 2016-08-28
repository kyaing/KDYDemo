//
//  UIView+GestureBlock.h
//  KDYDemo
//
//  Created by zhongye on 16/3/1.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock) (UIGestureRecognizer *gestureRecognizer);

/**
 *  UIView的单击和长按手势的处理事
 */
@interface UIView (GestureBlock)

/**
 *  单击事件
 *
 *  @param block 手势block
 */
- (void)ky_addTapActionWithBlock:(GestureActionBlock)block;

/**
 *  长按事件
 *
 *  @param block 手势block
 */
- (void)ky_addLongActionWithBlock:(GestureActionBlock)block;

@end

