//
//  KDHomeViewController.h
//  KDYDemo
//
//  Created by zhongye on 15/12/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：微博首页

/**
 思路：
    - 将微博中的Model数据创建好，它到底有多少种类呢：文字、图片、链接、话题、标签、用户、微博正文等等。
    - 页面布局类。_layoutArr -> 这个是微博首页最为重要的类了。它实现了对数据的计算和布局，及预渲染等等知识点。
    - 再把自定义Cell写好。
 */

#import <UIKit/UIKit.h>

@interface KDHomeViewController : UIViewController

@end

