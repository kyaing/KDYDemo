//
//  FrameHeightCell.h
//  KDYDemo
//
//  Created by zhongye on 16/3/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHeightModel.h"
#import "FrameHeightCellLayout.h"

/*
 总结：
    这里用到了YYText来支持图文混排，很好的是它已经做好了高度的计算，也就不需要我们再次手动用UILabel
    的方法来计算，但是也要深入理解它YYText是如何得到YYLabel的总高度的？
    然后在heigthForRowAtIndexPath:方法中得到所有控件的高度之和。
 
    由于页面存在较大的卡顿，所以使用FrameHeightCellLayout来后台计算高度，最后再来刷新UI。
 */

@protocol FrameHeightCellDelegate;
@interface FrameHeightCell : UITableViewCell

@property (nonatomic, weak) id <FrameHeightCellDelegate> delegate;

/**
 *  计算Cell高度
 *
 *  @param model 数据模型
 *
 *  @return 返回高度
 */
//改进后，不用此方式计算高度!
//+ (CGFloat)configureCellHeightWithModel:(CellHeightModel *)model;

/**
 *  布局Cell
 *
 *  @param layout 布局类
 */
- (void)setLayout:(FrameHeightCellLayout *)layout;

@end

@protocol FrameHeightCellDelegate <NSObject>

@optional
- (void)cell:(FrameHeightCell *)cell didClickInLabel:(YYLabel *)label textRange:(NSRange)textRange;

@end

