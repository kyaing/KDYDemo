//
//  KDPhotoBrowser.m
//  KDYDemo
//
//  Created by zhongye on 16/1/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDPhotoBrowser.h"
#import "KDPhotoImageView.h"
#import "KDPhotoBrowserConfig.h"

@interface KDPhotoBrowser () <UIScrollViewDelegate> {
    UIScrollView *_scrollView;  //图片的滚动视图
    UILabel      *_indexlabel;  //索引标签
    UIButton     *_saveButton;  //保存图片按钮
    
    BOOL _isShowedFirstView;
    BOOL _isWillDisappear;
}

@end

@implementation KDPhotoBrowser

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

//通知相关视图它们父视图已经变化
- (void)didMoveToSuperview {
    [self _setupScrollView];
    [self _setupToolbar];
}

///设置滚动视图
- (void)_setupScrollView {
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    //添加图片
    for (int i = 0; i < self.totalImageCount; i++) {
        KDPhotoImageView *imageView = [KDPhotoImageView new];
        imageView.tag = i;
        
        /*对图片单双击同时支持*/
        //单击图片
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClickPhoto:)];
        
        //双击放大图片
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleScalePhoto:)];
        doubleTap.numberOfTapsRequired = 2;
        
        //监测双击失效后，再实现单击；从而达到单双击共存
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
        [imageView addGestureRecognizer:singleTap];
        [imageView addGestureRecognizer:doubleTap];
        
        [_scrollView addSubview:imageView];
    }
    
    //加载对应index的图片
    [self _loadPhotoImageAtIndex:self.currentImageIndex];
}

///设置工具栏(包括顶部index和底部按钮)
- (void)_setupToolbar {
    //顶部索引标签
    _indexlabel = [UILabel new];
    _indexlabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    _indexlabel.font = [UIFont systemFontOfSize:20.f];
    _indexlabel.textAlignment = NSTextAlignmentCenter;
    _indexlabel.textColor = [UIColor whiteColor];
    _indexlabel.layer.cornerRadius = 5.f;
    _indexlabel.layer.masksToBounds = YES;
    _indexlabel.layer.borderWidth = 0.1;
    _indexlabel.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if (self.totalImageCount > 1) {
        _indexlabel.text = [NSString stringWithFormat:@"1/%ld", self.totalImageCount];
    }
    [self addSubview:_indexlabel];
    
    //底部保存按钮
    _saveButton = [UIButton new];
    _saveButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_saveButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_saveButton addTarget:self action:@selector(saveImageAction:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.layer.cornerRadius = 2.f;
    _saveButton.layer.masksToBounds = YES;
    _saveButton.layer.borderWidth = 0.1;
    _saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self addSubview:_saveButton];
}

/**
 * 显示图片浏览器
 */
- (void)showPhotoBrowser {
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *keyWindow = application.keyWindow;
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
    
    //KVO观察frame
    [keyWindow addObserver:self forKeyPath:@"frame" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
    }
}

#pragma mark - Photo
- (void)_loadPhotoImageAtIndex:(NSInteger)index {
    KDPhotoImageView *imageView = _scrollView.subviews[index];
    self.currentImageIndex = index;
    if (imageView.hasLoadedImage) {
        return;
    }
    
    if ([self _highImageURLAtIndex:index]) {
        
    } else {
        imageView.image = [self _photoImageForIndex:index];
    }
    
    imageView.hasLoadedImage = YES;
}

- (UIImage *)_photoImageForIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(photoBrowser:photoImageAtIndex:)]) {
        return [self.delegate photoBrowser:self photoImageAtIndex:index];
    }
    
    return nil;
}

- (NSURL *)_highImageURLAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(photoBrowser:highQualityImageURLAtIndex:)]) {
        return [self.delegate photoBrowser:self highQualityImageURLAtIndex:index];
    }
    
    return nil;
}

/**
 * 显示点击对应的图片即某种意义上的第一张
 */
- (void)_showFirstPhotoImage {
    UIView *sourceView = self.layoutPhotoContainerView.subviews[self.currentImageIndex];
    CGRect rect = [self.layoutPhotoContainerView convertRect:sourceView.frame toView:self];
    
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.image = [self _photoImageForIndex:self.currentImageIndex];
    [self addSubview:tempView];
    
    CGRect targetTemp = [_scrollView.subviews[self.currentImageIndex] bounds];
    
    tempView.frame = rect;
    tempView.contentMode = [_scrollView.subviews[self.currentImageIndex] contentMode];
    _scrollView.hidden = YES;
    
    //动画显示对应的图片
    [UIView animateWithDuration:0.4 animations:^{
        tempView.center = self.center;
        tempView.bounds = (CGRect){CGPointZero, targetTemp.size};
        
    } completion:^(BOOL finished) {
        _isShowedFirstView = YES;
        [tempView removeFromSuperview];
        
        _scrollView.hidden = NO;
    }];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    rect.size.width += 10 * 2;
    
    _scrollView.bounds = rect;
    _scrollView.center = self.center;
    
    CGFloat yPos = 0;
    CGFloat width = _scrollView.frame.size.width - 10 * 2;
    CGFloat height = _scrollView.frame.size.height;
    
    //遍历图片浏览器中的图片
    [_scrollView.subviews enumerateObjectsUsingBlock:^(KDPhotoImageView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat xPos = 10 + idx * (10 * 2 + width);
        obj.frame = CGRectMake(xPos, yPos, width, height);
    }];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);
    
    _indexlabel.frame = CGRectMake((kScreenWidth - 60)/2, 20, 80, 30);
    _saveButton.frame = CGRectMake(30, kScreenHeight - 45, 50, 25);
    
    if (!_isShowedFirstView) {
        [self _showFirstPhotoImage];
    }
}

#pragma mark - Events
/** 
 * 浏览模式下点击图片缩回去
 */
- (void)singleClickPhoto:(UITapGestureRecognizer *)recognizer {
    _scrollView.hidden = YES;
    _isWillDisappear = YES;
    
    KDPhotoImageView *currentImageView = (KDPhotoImageView *)recognizer.view;
    NSInteger currentIndex = currentImageView.tag;
    
    UIView *sourceImageView = self.layoutPhotoContainerView.subviews[currentIndex];
    //将sourceImageView所在的视图rect转换成当前的rect
    CGRect targetRect = [self.layoutPhotoContainerView convertRect:sourceImageView.frame toView:self];
    
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.contentMode = sourceImageView.contentMode;
    tempView.clipsToBounds = YES;
    tempView.image = currentImageView.image;
    CGFloat h = (self.bounds.size.width / currentImageView.image.size.width) * currentImageView.image.size.height;
    
    if (!currentImageView.image) {
        h = self.bounds.size.height;
    }
    
    tempView.bounds = CGRectMake(0, 0, self.bounds.size.width, h);
    tempView.center = self.center;
    [self addSubview:tempView];
    
    //动画缩回原位置
    [UIView animateWithDuration:0.4 animations:^{
        tempView.frame = targetRect;
        _indexlabel.alpha = 0.1;
        self.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)doubleScalePhoto:(UITapGestureRecognizer *)recognizer {
    NSLog(@"doubleScalePhoto");
}

/**
 *  将图片保存到iPhone相册中
 */
- (void)saveImageAction:(UIButton *)button {
    NSInteger index = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    UIImageView *currentImageView = _scrollView.subviews[index];
    
    //保存到相册中
    UIImageWriteToSavedPhotosAlbum(currentImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.9f];
    label.layer.cornerRadius = 5.f;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 100, 35);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = @"保存成功";
    
    [KeyWindow addSubview:label];
    [KeyWindow bringSubviewToFront:label];
    
    //1秒后删除提示
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.f];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    //多加一半的scrollView宽度，为了能更快地更新索引
    NSInteger index = (scrollView.contentOffset.x + scrollViewW * 0.5) / scrollViewW;
    
    //更新顶部索引值
    if (!_isWillDisappear) {
        _indexlabel.text = [NSString stringWithFormat:@"%ld/%ld", (index + 1), self.totalImageCount];
    }
    
    //加载滚动后对应的图片
    [self _loadPhotoImageAtIndex:index];
}

@end

