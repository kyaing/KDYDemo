//
//  CarouselViewLayout.h
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, CarouselAnimation) {
    CarouselAnimationLinear,
    CarouselAnimationCarousel,
    CarouselAnimationCoverFlow,
};

@interface CarouselViewLayout : UICollectionViewLayout

@property (nonatomic) CarouselAnimation carouselAnim;
@property (nonatomic) CGSize    itemSize;     //item的大小
@property (nonatomic) NSInteger visibleCount;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;  //设置滚动方向

- (instancetype)initWithAnimation:(CarouselAnimation)animation;

@end

