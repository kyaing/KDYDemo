//
//  KDBaseCollectionViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDBaseCollectionViewController.h"
#import "HeaderCollectionView.h"
#import "CarouselCollectionCell.h"

static NSString *cellIdentifer = @"collectionView";
static NSString *headerIdentifer = @"headerView";

@interface KDBaseCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KDBaseCollectionViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基础用法(附带Cell重排)";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 21; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%ld", i]];
    }
    
    [self setupCollectView];
}

- (void)setupCollectView {
    CGFloat width = (kScreenWidth - 4 * 10) / 3.0;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(width, width)];
    [flowLayout setMinimumInteritemSpacing:10];
    [flowLayout setMinimumLineSpacing:10];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    //创建UICollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    //注册Cell
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifer];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CarouselCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdentifer];
    
    //注册头视图
    [self.collectionView registerClass:[HeaderCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifer];
    
    //CollectionView添加重排功能(iOS9才提供的功能，并且在有页眉的时候重振有问题)
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
    [self.collectionView addGestureRecognizer:longPress];
}

#pragma mark - UICollectionViewDataSource
//多个Section的时候，可以在自定义追回视图(HeaderView/FooterView)
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 5;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [_dataArray objectAtIndex:indexPath.row];
    CarouselCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    cell.backgroundColor = RGB(120, 170, 230);
    cell.label.text = title;

    return cell;
}

//设置CollectionVie的追回视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderCollectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifer forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor greenColor];
        
        return headerView;
    }
    
    return nil;
}

//移动item(重写此方法，即使什么都不写也能移动重排)
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *temp = [_dataArray objectAtIndex:sourceIndexPath.row];
    
    //改变数据源
    [_dataArray removeObjectAtIndex:sourceIndexPath.row];
    [_dataArray insertObject:temp atIndex:destinationIndexPath.row];
}

//#pragma mark - UICollectionViewDelegateFlowLayout
/**
 UICollectionViewDelegateFlowLayout负责整个CollectionView的显示
 */
////item的显示大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat width = (kScreenWidth - 5 * 10) / 4.0;
//    return CGSizeMake(width, width);
//}
//
////Section的内边距
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
//
////Section中Cell的上下边距(line spacing：行距)
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 10.f;
//}
//
////Section中Cell的左右边距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10.f;
//}
//
////页眉大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(kScreenWidth, 30);
//}

#pragma mark - Press Action
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)gesture {
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        }
            
        case UIGestureRecognizerStateChanged:{
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
            break;
        }
            
        case UIGestureRecognizerStateEnded:{
            [self.collectionView endInteractiveMovement];
            break;
        }
            
        default: {
            [self.collectionView cancelInteractiveMovement];
            break;
        }
    }
}

@end

