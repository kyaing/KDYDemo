//
//  UILabel+Create.m
//  KDYDemo
//
//  Created by zhongye on 16/3/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UILabel+Create.h"

@implementation UILabel (Create)

+ (UILabel *)ky_createLabel:(NSTextAlignment)textAlignment
                    fontNum:(CGFloat)fontNum
                  textColor:(UIColor *)textColor
                       text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = textAlignment;
    label.font = [UIFont systemFontOfSize:fontNum];
    label.textColor = textColor;
    label.text = text;
    
    return label;
}

@end

