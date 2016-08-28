//
//  PhotoListCell.h
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol PhotoListCellDelegate <NSObject>


@end

@interface PhotoListCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ALAsset     *asset;
@property (nonatomic, weak) id <PhotoListCellDelegate> delegate;

- (void)bind:(ALAsset *)asset selectionFilter:(NSPredicate *)selectionFilter isSeleced:(BOOL)isSeleced;

@end

