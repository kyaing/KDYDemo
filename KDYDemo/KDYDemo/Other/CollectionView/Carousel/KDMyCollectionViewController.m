//
//  KDMyCollectionViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDMyCollectionViewController.h"
#import "CarouselCollectionCell.h"

@interface KDMyCollectionViewController ()

@end

@implementation KDMyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    //代码手写注册Cell
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //使用Xib注册Cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CarouselCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarouselCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = RGB(120, 170, 230);
    cell.label.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了第%ld个item", (long)indexPath.row);
}

@end

