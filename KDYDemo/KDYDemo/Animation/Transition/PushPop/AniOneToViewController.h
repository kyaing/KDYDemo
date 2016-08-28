//
//  AniOneToViewController.h
//  KDYDemo
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDNavigationControllerDelegate <NSObject, UINavigationControllerDelegate>
@optional

@end

@interface AniOneToViewController : UIViewController <UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *buttonTwo;

@end

