//
//  KDDisplayViewController.h
//  KDYDemo
//
//  Created by zhongye on 15/12/11.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：顶部滚动条

/**
 思路：
 像一些新闻类或视频类的APP，它们展示的种类从大从而导致内容从多，所以就出现了一种左右滚动而
 展示相应类型的内容。
 那用什么做呢？(UIScrollView + UITableView)?
 KDDisplayViewController->作为一个基类，统一定义接口。
 
 功能：
    - 页面左右滑动，致使标题栏跟着同样滚动；但标题栏滚动时，内容页面不会随之滚动。
    - 标题栏应该要有点击事件，可以跳到对应的页面。
    - 标题栏滚动效果依据不同的APP而不同，同时要设置标题的宽度。
    - 除此之外，这种滚动标题并不是在导航栏上添加的那种样式，要给以区分！
 怎么进行封装呢：
    - 将需要多个滚动的控制器作为子控制器，加入到你要实现的控制器中。
    - 将诸如此类的控件结构统一成为一个共性：
    - UIScrollView(标题视图)
      UIScrollView(内容视图) -> 承载着多个子控制器(这些子控制器有一个共同的父控制器)。
    - 自己仍然对于这种计算坐标和scrollView方面的知识还是不熟悉！
 
    多想想这个例子，花了不少时间！
    想想原理，想想流程思路！
 */

#import <UIKit/UIKit.h>

// 颜色渐变样式
typedef enum : NSUInteger {
    YZTitleColorGradientStyleRGB,
    YZTitleColorGradientStyleFill,
} YZTitleColorGradientStyle;

@interface KDDisplayViewController : UIViewController

/** 是否全屏 */
@property (nonatomic, assign) BOOL isfullScreen;

#pragma mark - 标题
/** 标题背景颜色 */
@property (nonatomic, strong) UIColor *titleScrollViewColor;

/** 正常标题颜色 */
@property (nonatomic, strong) UIColor *normalColor;

/** 选中标题颜色 */
@property (nonatomic, strong) UIColor *selectColor;

/** 标题字体 */
@property (nonatomic, strong) UIFont *titleFont;

/** 标题高度 */
@property (nonatomic, assign) CGFloat titleHeight;

#pragma mark - 遮盖
/** 是否显示遮盖 */
@property (nonatomic, assign) BOOL isShowTitleCover;

/** 遮盖颜色 */
@property (nonatomic, strong) UIColor *coverColor;

/** 遮盖圆角半径 */
@property (nonatomic, assign) CGFloat coverCornerRadius;

#pragma mark - 颜色渐变
/** 字体是否渐变 */
@property (nonatomic, assign) BOOL isShowTitleGradient;

/** 颜色渐变样式 */
@property (nonatomic, assign) YZTitleColorGradientStyle titleColorGradientStyle;

/** 开始颜色,取值范围0~1 */
@property (nonatomic, assign) CGFloat startR;

@property (nonatomic, assign) CGFloat startG;

@property (nonatomic, assign) CGFloat startB;

/** 完成颜色,取值范围0~1 */
@property (nonatomic, assign) CGFloat endR;

@property (nonatomic, assign) CGFloat endG;

@property (nonatomic, assign) CGFloat endB;

#pragma mark - 字体缩放
/** 字体放大 */
@property (nonatomic, assign) BOOL isShowTitleScale;

/** 字体缩放比例 */
@property (nonatomic, assign) CGFloat titleScale;

#pragma mark - 下标
/** 是否需要下标 */
@property (nonatomic, assign) BOOL isShowUnderLine;

/** 下标颜色 */
@property (nonatomic, strong) UIColor *underLineColor;

/** 下标高度 */
@property (nonatomic, assign) CGFloat underLineH;

@end

