//
//  KDWheelViewController.h
//  KDYDemo
//
//  Created by zhongye on 15/12/7.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：实现轮播组件功能

/**
 思路：
    可以就封装轮播组件，来简单总结下如何封装组件，以及需要注意的细节。
    一个封装得很优秀且复杂度不高的组件就像一个魔法盒子，只需要触发启动开关，就可以达到期待的效果，那么极简的触发参数
    和条件才是组件封装的精髓。
 
    需要注意的是：
    - 这个组件要做什么。
    - 这个组件至少需要知道哪些信息。
    - 这个组件会反馈哪些信息。
    我们要做的东西不仅仅适用于单个项目，还应该是通用的，即可以适应于大部分同种类需求。
 
    组件需要做什么：
    - 展示多张图片。
    - 可以向左向右翻页。
    - PageControl的状态会根据图片的滚动而相应的改变。 
    隐含的会做：
    - 支持左右两侧的无限循环滚动。
    - 自动轮播。
    - 支持手动滑动。
    - 支持点击并进行相关的响应事件。
    - 图片的缓存。
 */

#import <UIKit/UIKit.h>

@interface KDWheelViewController : UIViewController

@end

