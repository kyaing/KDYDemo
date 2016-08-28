//
//  PhotoListCell.m
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "PhotoListCell.h"

@implementation PhotoListCell

- (void)bind:(ALAsset *)asset selectionFilter:(NSPredicate *)selectionFilter isSeleced:(BOOL)isSeleced {
    self.asset = asset;
    
    if (self.imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.backgroundColor = [UIColor whiteColor];
    }
    
//    if (!self.tapAssetView) {
//        BoTapAssetView *tapView = [[BoTapAssetView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//        tapView.delegate = self;
//        [self.contentView addSubview:tapView];
//        self.tapAssetView = tapView;
//    }
    
    if ([asset isKindOfClass:[UIImage class]]) {
        [self.imageView setImage:(UIImage *)asset];
    } else {
        [self.imageView setImage:[UIImage imageWithCGImage:asset.aspectRatioThumbnail]];
    }
    
    //利用扩展添加圆角，注意要在设置图片之后
    [self.imageView ky_addCornerRadius:3.f];
    
//    _tapAssetView.disabled = ![selectionFilter evaluateWithObject:asset];
//    _tapAssetView.selected = isSeleced;
}

@end

