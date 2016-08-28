//
//  PhotoListCollectionView.h
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol PhotoListViewDelegate <NSObject>

/**
 *  选择某个资源图片
 *
 *  @param asset 某个资源
 */
- (void)didSelectedAsset:(ALAsset *)asset;

@end

@interface PhotoListCollectionView : UICollectionView

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, weak)   id<PhotoListViewDelegate> listDelegate;

@end

