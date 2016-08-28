//
//  KDWeiXinContactViewController.h
//  KDYDemo
//
//  Created by zhongye on 15/12/8.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：自定义联系人界面

/**
 目标：
    此联系人界面需要达到的效果有：
    - 自定义索引。
        - 不占用屏幕右侧20个像素的距离；
        - 有向上的箭头表示移动到最上端；
    - 左滑动界面可以给联系人备注，或者可以删除，即左滑出现多个按钮(iOS8以上)；
        - 备注和删除联系人要用本地化处理；
        - 选择什么本地化处理呢？Sqlite还是Core Data。
        - 左滑删除在iOS8以上可以用新的API，若在iOS8之前，应该怎么做呢？
        - 要想在左滑删除中显示多个图标怎么做？
    - 搜索联系人，最好可以高亮显示搜索结果。
    以上这些目标，也是在开发中或者学习中常用的社交APP所常见的知识点。
 */

#import <UIKit/UIKit.h>

@interface KDWeiXinContactViewController : UIViewController

@end

