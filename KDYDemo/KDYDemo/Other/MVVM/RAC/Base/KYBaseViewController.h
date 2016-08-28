//
//  KDViewController.h
//  KDYDemo
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDViewProtocol;

@protocol KDViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <KDViewProtocol>)viewModel;

- (void)ky_bindViewModel;
- (void)ky_setupSubViews;
- (void)ky_layoutNavigation;
- (void)ky_reqeustData;

@end

@interface KYBaseViewController : UIViewController

@end

