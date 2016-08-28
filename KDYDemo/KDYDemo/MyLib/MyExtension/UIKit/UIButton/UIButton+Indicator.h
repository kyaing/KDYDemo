//
//  UIButton+Indicator.h
//  KDYDemo
//
//  Created by zhongye on 16/2/23.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  按钮点击后，指示器和文本按需要显示和隐藏
 */
@interface UIButton (Indicator)

/**
 *  显示指示器
 */
- (void)ky_showBtnIndicator;

/**
 *  隐藏指示器
 */
- (void)ky_hideBtnIndicator;

@end

