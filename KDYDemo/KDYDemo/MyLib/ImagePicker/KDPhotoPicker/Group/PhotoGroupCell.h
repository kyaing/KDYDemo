//
//  PhotoGroupCell.h
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoGroupCell : UITableViewCell

@property (nonatomic, weak) UIImageView *groupImageView;
@property (nonatomic, weak) UILabel     *groupTextLabel;

- (void)bind:(ALAssetsGroup *)assetsGroup;

@end

