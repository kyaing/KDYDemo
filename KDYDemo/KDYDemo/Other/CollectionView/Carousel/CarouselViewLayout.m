//
//  CarouselViewLayout.m
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CarouselViewLayout.h"

#define INTERSPACEPARAM  0.65

@interface CarouselViewLayout () {
    CGFloat _viewHeight;
    CGFloat _itemHeight;
}

@end

@implementation CarouselViewLayout

- (instancetype)initWithAnimation:(CarouselAnimation)animation {
    self = [super init];
    if (self) {
        self.carouselAnim = animation;
    }
    
    return self;
}

#pragma mark - UICollectionViewLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    if (self.visibleCount < 1) {
        self.visibleCount = 5;
    }
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        _viewHeight = CGRectGetHeight(self.collectionView.frame);
        _itemHeight = self.itemSize.height;
        self.collectionView.contentInset = UIEdgeInsetsMake((_viewHeight - _itemHeight) / 2, 0, (_viewHeight - _itemHeight) / 2, 0);
        
    } else {
        _viewHeight = CGRectGetWidth(self.collectionView.frame);
        _itemHeight = self.itemSize.width;
        self.collectionView.contentInset = UIEdgeInsetsMake(0, (_viewHeight - _itemHeight) / 2, 0, (_viewHeight - _itemHeight) / 2);
    }
}

- (CGSize)collectionViewContentSize {
    //得到Cell的个数
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        return CGSizeMake(CGRectGetWidth(self.collectionView.frame), cellCount * _itemHeight);
    }
    
    return CGSizeMake(cellCount * _itemHeight, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat centerY = (self.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.contentOffset.y : self.collectionView.contentOffset.x) + _viewHeight / 2;
    NSInteger index = centerY / _itemHeight;
    NSInteger count = (self.visibleCount - 1) / 2;
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    
    //添加Cells
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    
    CGFloat cY = (self.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.contentOffset.y : self.collectionView.contentOffset.x) + _viewHeight / 2;
    CGFloat attributesY = _itemHeight * indexPath.row + _itemHeight / 2;
    attributes.zIndex = -ABS(attributesY - cY);
    
    CGFloat delta = cY - attributesY;
    CGFloat ratio =  - delta / (_itemHeight * 2);
    CGFloat scale = 1 - ABS(delta) / (_itemHeight * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat centerY = attributesY;
    
    switch (self.carouselAnim) {
        case CarouselAnimationLinear:
            centerY = cY + sin(ratio * M_PI_2) * _itemHeight * INTERSPACEPARAM;
            break;
    
        case CarouselAnimationCoverFlow: {
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -1.0/400.0f;
            transform = CATransform3DRotate(transform, ratio * M_PI_4, 1, 0, 0);
            attributes.transform3D = transform;
        }
            break;
            
        default:
            break;
    }
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        attributes.center = CGPointMake(CGRectGetWidth(self.collectionView.frame) / 2, centerY);
    } else {
        attributes.center = CGPointMake(centerY, CGRectGetHeight(self.collectionView.frame) / 2);
    }
    
    return attributes;
}

//自动对齐网格
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat index = roundf(((self.scrollDirection == UICollectionViewScrollDirectionVertical ? proposedContentOffset.y : proposedContentOffset.x) + _viewHeight / 2 - _itemHeight / 2) / _itemHeight);
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        proposedContentOffset.y = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;
    } else {
        proposedContentOffset.x = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;
    }
    
    return proposedContentOffset;
}

//当CollectionView的bounds更新时，是否需要更新layout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

@end

