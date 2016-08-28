//
//  KDQQContactViewController.h
//  KDYDemo
//
//  Created by zhongye on 15/12/9.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

/**
 思路：
    要想实现类似QQ折叠的联系人列表效果，首先想到还是要用tableView实现，
    其次要自定义section的头视图，为什么不使用UIView，而是要使用UITableViewHeaderFooterView，
    因为继承UITableViewHeaderFooterView可以像UITableViewCell那样进行重用，提升性能。
 
    同时，在模型的定义一个属性，这个属性用于处理一个分组是否被“折叠”，其实就是根据这个属性来改变row的行数。
 */

#import <UIKit/UIKit.h>

@interface KDQQContactViewController : UIViewController

@end

