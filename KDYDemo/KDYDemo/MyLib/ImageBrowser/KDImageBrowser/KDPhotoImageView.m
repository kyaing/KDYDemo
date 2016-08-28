//
//  KDPhotoImageView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDPhotoImageView.h"

@interface KDPhotoImageView () <UIGestureRecognizerDelegate> {
    UIScrollView *_scroll;
    UIImageView *_scrollImageView;
    
    UIScrollView *_zoomingScroolView;
    UIImageView *_zoomingImageView;
    CGFloat _totalScale;
}

@end

@implementation KDPhotoImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        //捏合手势缩放图片
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImageAction:)];
        pinch.delegate = self;
        [self addGestureRecognizer:pinch];
    }
    
    return self;
}

- (void)zoomImageAction:(UIPinchGestureRecognizer *)recognizer {
    
}

@end

