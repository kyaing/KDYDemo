//
//  UIButton+Timing.h
//  KDYDemo
//
//  Created by zhongye on 16/2/24.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击按钮时计时功能
 */
@interface UIButton (Timing)

/**
 *  带有倒计时功能的按钮
 *
 *  @param timeout    倒计时总时长
 *  @param tittle     原标题
 *  @param waitTittle 倒计时时的标题
 */
- (void)ky_startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;

@end

