//
//  KDFlowCollectionViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDFlowCollectionViewController.h"
#import "CarouselCollectionCell.h"
#import "MyCollectionLayout.h"

@interface KDFlowCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation KDFlowCollectionViewController

static NSString *const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCollectView];
}

- (void)setupCollectView {
    //使用自定义的布局
    MyCollectionLayout *layout = [[MyCollectionLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    //注册Cell
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CarouselCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //为Cell添加手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
}

//长按移动item，并且重新排序
- (void)longPressAction:(UILongPressGestureRecognizer *)gesture {
    CGPoint startPoint = [gesture locationInView:self.collectionView];
    NSIndexPath *selectIndexPath = nil;
    
    //判断手势状态(begin、change、end)
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            selectIndexPath = [self.collectionView indexPathForItemAtPoint:startPoint];
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
            
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarouselCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = RGB(120, 170, 230);
    cell.label.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout {
    
    UICollectionViewTransitionLayout *transition = [[UICollectionViewTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    
    return transition;
}

@end
