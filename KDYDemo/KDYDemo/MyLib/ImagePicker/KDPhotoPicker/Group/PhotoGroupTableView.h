//
//  PhotoGroupTableView.h
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol PhotoGroupViewDelegate <NSObject>

/**
 *  选择某个资源组
 *
 *  @param assetsGroup 资源组
 */
- (void)didSelectedGroup:(ALAssetsGroup *)assetsGroup;

@end

@interface PhotoGroupTableView : UITableView

@property (nonatomic, weak)   id<PhotoGroupViewDelegate> groupDelegate;
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

/**
 *  显示相册
 */
- (void)setupGroups;

@end

