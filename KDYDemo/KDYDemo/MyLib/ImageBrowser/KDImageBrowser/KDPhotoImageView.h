//
//  KDPhotoImageView.h
//  KDYDemo
//
//  Created by zhongye on 16/1/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KDPhotoImageView : UIImageView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL isScaled;
@property (nonatomic, assign) BOOL hasLoadedImage;

@end

