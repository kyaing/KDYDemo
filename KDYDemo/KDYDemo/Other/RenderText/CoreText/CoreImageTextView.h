//
//  CoreImageTextView.h
//  KDYDemo
//
//  Created by kaideyi on 16/1/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：文字中加入图片的混排

/**
 思路：
    CoreText从绘制纯文本到绘制图片，依然是使用NSAttributedString，
    只不过图片的实现方式是用一个空白字符作为在NSAttributedString中的占位符，
    然后设置代理，告诉CoreText给该占位字符留出一定的宽高。最后把图片绘制到预留的位置上。
 */

#import <UIKit/UIKit.h>

@interface CoreImageTextView : UIView
@property (nonatomic, strong) UIImage *image;

@end

