//
//  KDLayoutPhotoImageView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDLayoutPhotoImageView.h"
#import "KDPhotoBrowser.h"

@interface KDLayoutPhotoImageView () <KDPhotoBrowserDelegate> {
    
}

@end

@implementation KDLayoutPhotoImageView 

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setPhotosArray:(NSArray *)photosArray {
    _photosArray = photosArray;
    
    //先清除图片数组中的图片
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGRect frame = self.frame;
    if (photosArray.count == 0) {
        frame.size.height = 0;
        return;
    }
    
    NSInteger itemWidth = [self _itemWidthForPhotoArray:photosArray];
    NSInteger itemHeight = 0;
    
    if (photosArray.count == 1) {
        UIImage *image = [UIImage imageNamed:photosArray.firstObject];
        if (image.size.width) {
            itemHeight = image.size.height / image.size.width * itemWidth;
        }
    } else {
        itemHeight = itemWidth;
    }
    
    long perRowItemCount = [self _perRowCountsForPhotoArray:photosArray];
    CGFloat margin = 10;
    
    //布局图片
    [photosArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        
        //单独的每张图片
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 1.f;
        imageView.layer.masksToBounds = YES;
        
        CGFloat xPos = columnIndex * (itemWidth + margin);
        CGFloat yPos = rowIndex * (itemHeight + margin);
        CGFloat width = itemWidth;
        CGFloat height = itemHeight;
        imageView.frame = CGRectMake(xPos, yPos, width, height);
        
        imageView.image = [UIImage imageNamed:obj];
        imageView.userInteractionEnabled = YES;
        imageView.tag = idx;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
    }];
    
    CGFloat width = perRowItemCount * itemWidth + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(photosArray.count * 1.0 / perRowItemCount);
    CGFloat height = columnCount * itemHeight + (columnCount - 1) * margin;
    
    frame.size.width = width;
    frame.size.height = height;
}

//根据图片数组返回每行个数
- (NSInteger)_perRowCountsForPhotoArray:(NSArray *)array {
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

- (NSInteger)_itemWidthForPhotoArray:(NSArray *)array {
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat width = [UIScreen mainScreen].bounds.size.width > 320 ? 100 : 80;
        return width;
    }
}

//点击某张图片并进入浏览模式
- (void)tapImageView:(UITapGestureRecognizer *)recognizer {
    //得到点击的图片
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    KDPhotoBrowser *browser = [[KDPhotoBrowser alloc] init];
    browser.totalImageCount = _photosArray.count;
    browser.currentImageIndex = imageView.tag;
    browser.layoutPhotoContainerView = self;
    browser.delegate = self;
    
    //显示浏览器
    [browser showPhotoBrowser];
}

#pragma mark - KDPhotoBrowserDelegate
- (UIImage *)photoBrowser:(KDPhotoBrowser *)photoBrowser photoImageAtIndex:(NSInteger)index {
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end

