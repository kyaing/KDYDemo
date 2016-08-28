//
//  UILabel+Create.h
//  KDYDemo
//
//  Created by zhongye on 16/3/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Create)

/**
 *  简化创建UILabel的步骤
 *
 *  @param textAlignment 文本对齐
 *  @param fontNum       字体大小
 *  @param textColor     字体颜色
 *  @param text          文本内容
 *
 *  @return
 */
+ (UILabel *)ky_createLabel:(NSTextAlignment)textAlignment
                    fontNum:(CGFloat)fontNum
                  textColor:(UIColor *)textColor
                       text:(NSString *)text;

@end

