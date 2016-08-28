//
//  KDPhotoBrowser.h
//  KDYDemo
//
//  Created by zhongye on 16/1/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：图片浏览器

/**
 思路：
    图片浏览器，实现的功能：
    - 微博或微信打开的九宫格后，展开的图片浏览器任何位置打开，并自动缩回原位置。
    - 浏览器顶部显示当前页和总页数；底部显示保存图片(还可以添加点赞等，可做成配置的)。
    - 对单张图片可以缩放。
    - 图片除了可以加载本地图片，还应该可以加载网络URL图片。
    (如何设计高效的第三方库，易用性、扩展性、封装性等等)
 
 类：
    KDPhotoBrowser：图片浏览器类。
    KDPhotoImageView：单张图片。
    KDPhotoBrowserConfig：图片浏览器的配置信息。
    KDLayoutPhotoImageView：点开图片浏览器前的图片的展示布局承载视图
 */

#import <UIKit/UIKit.h>

@class KDPhotoBrowser;

@protocol KDPhotoBrowserDelegate <NSObject>
@required
- (UIImage *)photoBrowser:(KDPhotoBrowser *)photoBrowser photoImageAtIndex:(NSInteger)index;

@optional
- (NSURL *)photoBrowser:(KDPhotoBrowser *)photoBrowser highQualityImageURLAtIndex:(NSInteger)index;

@end

@interface KDPhotoBrowser : UIView

/** 图片总张数 */
@property (nonatomic, assign) NSInteger totalImageCount;

/** 当前图片索引 */
@property (nonatomic, assign) NSInteger currentImageIndex;

/** 图片的承载视图 */
@property (nonatomic, strong) UIView *layoutPhotoContainerView;

/** 代理 */
@property (nonatomic, weak) id <KDPhotoBrowserDelegate> delegate;

#pragma mark - Method
/** 显示图片浏览器 */
- (void)showPhotoBrowser;

@end

