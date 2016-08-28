//
//  WBHomeTableViewCell.h
//  KDYDemo
//
//  Created by zhongye on 16/2/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBHomeCellViewModel.h"

@interface WBHomeTableViewCell : UITableViewCell
@property (nonatomic, strong) WBHomeCellViewModel *homeCellViewModel;

- (void)drawCell;

@end

