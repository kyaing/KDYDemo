//
//  MyCollectionLayout.h
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：自定义布局

#import <UIKit/UIKit.h>

/**
 思路：
    - 首先需要重载几个必要的方法：
      prepareLayout、
      collectionViewContentSize、
      layoutAttributesForElementsInRect、
      layoutAttributesForItemAtIndexPath.
    - 自定义瀑布流，重点是确定Cell对应的UICollectionViewLayoutAttributes属性中的frame.
    - Cell宽度可以在列数确定后确定；Cell高度是随机生成的高度，这就带来一个问题，真实情况下高度怎么确定？
    - 最后的Cell存在缺口怎么办？
 */

@interface MyCollectionLayout : UICollectionViewLayout

@end

