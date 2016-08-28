//
//  CollectionAnimaLayout.m
//  KDYDemo
//
//  Created by kaideyi on 16/3/6.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CollectionAnimaLayout.h"

@implementation CollectionAnimaLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize {
    return CGSizeZero;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)finalizeCollectionViewUpdates {
    
}

//出现动画
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    return nil;
}

//消失动画
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    return nil;
}

@end

