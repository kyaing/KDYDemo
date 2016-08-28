//
//  KDMasnoryViewController.h
//  KDYDemo
//
//  Created by zhongye on 16/1/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：用Masonry设计出复合型Cell

#import <UIKit/UIKit.h>

/**
 要求：
    设计一个复合型的Cell，要根据Model数据的不同，而分别加载对应的View，同时内容还是动态的。
    (但是，这相对于不使用Masonry的纯代码方式，除了在自动布局上有很大优势，在其它方面上有无优势了？)
    这只是一个小测试Masonry如何设计较复杂的Cell，当然本例子中类型还是不够复杂，可以在接下来的例子中应用到实际项目中。
 
 思路：
    可以将一组(一个或多个)View包含在一个ContainerView中，然后对这个ContainerView
    设置一个height(或者width，具体看需求)的强约束并保存，默认deactive，在需要隐藏的时候，直接active这个约束就可以了。
 */

@interface KDMasonryViewController : UITableViewController

@end

