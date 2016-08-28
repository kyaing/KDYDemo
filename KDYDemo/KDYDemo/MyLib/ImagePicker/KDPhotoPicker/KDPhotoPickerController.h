//
//  KDPhotoPickerController.h
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface KDPhotoPickerController : UIViewController

@property (nonatomic, strong) NSPredicate    *selectionFilter;
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

@end

