//
//  MyCollectionLayout.m
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "MyCollectionLayout.h"

@interface MyCollectionLayout () {
    NSInteger _numberOfSectoins;  //总组数
    NSInteger _numberOfCellsInSections;  //组内的总Cell数
    NSInteger _columnCount;  //列数
    
    NSInteger _padding;
    NSInteger _cellMinHeight;
    NSInteger _cellMaxHeight;
    NSInteger _cellWidth;
    
    NSMutableArray *_cellXPointArray;  //记录每列Cell的X坐标
    NSMutableArray *_cellYPointArray;  //记录每列Cell的Y坐标
    NSMutableArray *_cellHeigthArray;  //记录Cell的随机高度
}

@end

@implementation MyCollectionLayout

#pragma mark - UICollectionViewLayout
/**
 以下方法是在自定义UICollecionViewLayout类时，需要重写的方法。
 */
//预加载layout，只会被执行一次
- (void)prepareLayout {
    [super prepareLayout];
    
    //初始化数据
    [self setupDatas];
    
    //计算Cell的宽高
    [self setupCellWidth];
    [self setupCellHeight];
}

//返回CollectionView的ContentSize的大小
- (CGSize)collectionViewContentSize {
    CGFloat height = [self maxCellYWithArray:_cellYPointArray];
    return CGSizeMake(kScreenWidth, height);
}

//返回一个数组，它存放的是为每个Cell的UICollectionViewLayoutAttributes属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    [self setupCellYAarray];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _numberOfCellsInSections; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    
    return array;
}

//为每个Cell绑定一个layout属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //为了实现瀑布流，只需要设置每个Cell的frame即可
    CGRect frame = CGRectZero;
    CGFloat cellHight = [_cellHeigthArray[indexPath.row] floatValue];
    NSInteger minYIndex = [self minCellYArrayWithArray:_cellYPointArray];
    
    CGFloat tempX = [_cellXPointArray[minYIndex] floatValue];
    CGFloat tempY = [_cellYPointArray[minYIndex] floatValue];
    
    frame = CGRectMake(tempX, tempY, _cellWidth, cellHight);
    
    //更新相应的Y坐标
    _cellYPointArray[minYIndex] = @(tempY + cellHight + _padding);
    
    attributes.frame = frame;
    
    return attributes;
}

#pragma mark - Private Methods
- (void)setupDatas {
    _numberOfSectoins = [self.collectionView numberOfSections];
    _numberOfCellsInSections = [self.collectionView numberOfItemsInSection:0];
    
    _columnCount = 3;
    _padding = 2;
    _cellMinHeight = 100;
    _cellMaxHeight = 240;
}

//根据列数计算Cell的宽度
- (void)setupCellWidth {
    //每个Cell的宽度
    _cellWidth = (kScreenWidth - (_columnCount + 1) * _padding) / _columnCount;
    
    _cellXPointArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i++) {
        CGFloat tempXPoint = _padding + (_cellWidth + _padding) * i;
        [_cellXPointArray addObject:@(tempXPoint)];
    }
}

//初始化每列Cell的Y轴坐标
- (void)setupCellYAarray {
    _cellYPointArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i ++) {
        [_cellYPointArray addObject:@(0)];
    }
}

//随机生成Cell的高度
- (void)setupCellHeight {
    _cellHeigthArray = [[NSMutableArray alloc] initWithCapacity:_numberOfCellsInSections];
    for (int i = 0; i < _numberOfCellsInSections; i++) {
        CGFloat cellHeight = arc4random() % (_cellMaxHeight - _cellMinHeight) + _cellMinHeight;
        [_cellHeigthArray addObject:@(cellHeight)];
    }
}

//得到CellY数组中的最大值
- (CGFloat)maxCellYWithArray:(NSMutableArray *)array {
    if (array.count == 0) {
        return 0.0f;
    }
    
    CGFloat max = [array[0] floatValue];
    for (NSNumber *tempNumber in array) {
        CGFloat temp = [tempNumber floatValue];
        if (max < temp) {
            max = temp;
        }
    }
    
    return max;
}

//得到CellY数组中的最小值的索引
- (CGFloat)minCellYArrayWithArray:(NSMutableArray *)array {
    if (array.count == 0) {
        return 0.0f;
    }
    
    NSInteger minIndex = 0;
    CGFloat min = [array[0] floatValue];
    
    for (int i = 0; i < array.count; i++) {
        CGFloat temp = [array[i] floatValue];
        if (min > temp) {
            min = temp;
            minIndex = i;
        }
    }
    
    return minIndex;
}

@end

