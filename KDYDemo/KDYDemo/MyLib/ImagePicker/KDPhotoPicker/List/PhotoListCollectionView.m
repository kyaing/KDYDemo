//
//  PhotoListCollectionView.m
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "PhotoListCollectionView.h"
#import "PhotoListCell.h"
#import "KDPhotoPickerController.h"

#define kWidth     [UIScreen mainScreen].bounds.size.width
#define kHeight    [UIScreen mainScreen].bounds.size.height
#define Margin     5.f
#define MarginNums 4
#define Column     3.f

#define identifer @"cell"

@interface PhotoListCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PhotoListCellDelegate>

@property (nonatomic, strong) NSMutableArray *assetsArray;

@end

@implementation PhotoListCollectionView

#pragma mark - Getter/Setter
- (NSMutableArray *)assetsArray {
    if (_assetsArray == nil) {
        _assetsArray = [NSMutableArray array];
    }
    
    return _assetsArray;
}

- (void)setAssetsGroup:(ALAssetsGroup *)assetsGroup {
    _assetsGroup = assetsGroup;
    
    //加载对应的一组资源
    [self setupAssetsGroup];
}

#pragma mark - Privates
- (void)setupAssetsGroup {
    [self.assetsArray removeAllObjects];
    
    NSMutableArray *tempList = [[NSMutableArray alloc] init];
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset) {
            [tempList addObject:asset];
            
        } else if (tempList.count > 0){
            //排序
            NSArray *sortedList = [tempList sortedArrayUsingComparator:^NSComparisonResult(ALAsset *first, ALAsset *second) {
                if ([first isKindOfClass:[UIImage class]]) {
                    return NSOrderedAscending;
                }
                
                id firstData = [first valueForProperty:ALAssetPropertyDate];
                id secondData = [second valueForProperty:ALAssetPropertyDate];
                
                return [secondData compare:firstData];  //降序
            }];
            [self.assetsArray addObjectsFromArray:sortedList];
            
            [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            [self reloadData];
        }
    };
    
    //得到排序好的资源组
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}

#pragma mark - Life Cycle
- (instancetype)init {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self = [[PhotoListCollectionView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight) collectionViewLayout:layout];
    self.backgroundColor = [UIColor whiteColor];
    
    if (self) {
        [self registerClass:[PhotoListCell class] forCellWithReuseIdentifier:identifer];
        self.dataSource = self;
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsArray.count > 0 ? self.assetsArray.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    cell.delegate = self;
    
    //数据绑定
    [cell bind:[self.assetsArray objectAtIndex:indexPath.row] selectionFilter:((KDPhotoPickerController *)_listDelegate).selectionFilter isSeleced:YES];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(Margin, Margin, Margin, Margin);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat length = (kWidth - MarginNums * Margin)/Column;
    return CGSizeMake(length, length);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Margin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return Margin;
}

#pragma mark - PhotoListCellDelegate

@end

