//
//  MasonryComplexCell.h
//  KDYDemo
//
//  Created by zhongye on 16/1/28.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ComplexCellType) {
    ComplexCellTextType,        //只有文本类型
    ComplexCellPhotoType,       //只有图片类型
    ComplexCellTextPhotoType    //文本和图片共存
};

/**
 *  设计此类时需要考虑的是文本、图片的显示有三种可能性：
 *  只有文本；只有图片；文本与图片共存。
 *  这里需要考虑是不仅是展示类型是不确定性，还有考虑的文本是动态变化的特性！
 */
@interface MasonryComplexCell : UITableViewCell

@property (nonatomic, assign) ComplexCellType cellType;

/**
 *  计算Cell的总高度
 */
+ (CGFloat)getCellsHeight:(ComplexCellType)cellType;

@end

