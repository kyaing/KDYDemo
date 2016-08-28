//
//  KDCollectionAnimaController.m
//  KDYDemo
//
//  Created by kaideyi on 16/3/6.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDCollectionAnimaController.h"
#import "CollectionAnimaLayout.h"

@interface KDCollectionAnimaController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KDCollectionAnimaController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Collection动画";
    self.view.backgroundColor = [UIColor whiteColor];
}

@end

