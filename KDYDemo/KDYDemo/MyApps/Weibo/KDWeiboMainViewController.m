//
//  KDWeiboMainViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDWeiboMainViewController.h"
#import "KDHomeViewController.h"
#import "KDMeViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"

@interface KDWeiboMainViewController () <SinaWeiboDelegate, SinaWeiboRequestDelegate>
@property (nonatomic, strong) SinaWeibo *sinaWeibo;

@end

@implementation KDWeiboMainViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"kaideyi";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //设置子控制器
    [self setupChildsVC];
    
    //开启定时器监测微博未读数
    //[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _sinaWeibo = delegate.sinaweibo;
}

//创建子控制器
- (void)setupChildsVC {
    KDHomeViewController *homeVC = [KDHomeViewController new];
    homeVC.view.backgroundColor = [UIColor whiteColor];
    
    KDMeViewController *meVC = [KDMeViewController new];
    meVC.view.backgroundColor = [UIColor whiteColor];
    
    [self addOneChildVC:homeVC title:@"首页" imageName:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    [self addOneChildVC:meVC title:@"我" imageName:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    self.viewControllers = @[homeVC, meVC];
}

#pragma mark - SinaWeiboDelegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    //认证的数据保存到本地，以防止下次要再次认证
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo {
    //移除认证的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Private Methods
- (void)addOneChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName
        selectedImage:(NSString *)selectedImage {
    //设置标题，相当于同时设置了导航栏标题和tabbar标题
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //设置tabBarItem的默认的文字颜色
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    [childVC.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    //设置选中的颜色
    NSMutableDictionary *selectTextAttr = [NSMutableDictionary dictionary];
    selectTextAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttr forState:UIControlStateSelected];
    
    //tabbar会重新渲染图片，所以要重新设置选择图片的模式
    UIImage *selectedImg = [UIImage imageNamed:selectedImage];
    selectedImg = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImg;
    
    ZYNavigationController *navigationVC = [[ZYNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navigationVC];
}

- (void)timeAction {
    //状态栏网络转圈
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    __weak KDWeiboMainViewController *weakSelf = self;
    [_sinaWeibo requestWithURL:@"remind/unread_count"
                      params:nil
                  httpMethod:@"Get"
                       block:^(NSDictionary *result) {
                           [weakSelf refreshUnReadView:result];
                       }];
}

- (void)refreshUnReadView:(NSDictionary *)result {
    //状态栏网络转圈停止
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSNumber *statusNum = [result objectForKey:@"status"];
    int number = [statusNum intValue];
    
    KDHomeViewController *homeVC = [KDHomeViewController new];
    if (number > 0) {
        if (number > 99) {
            number = 99;
        }
        
        homeVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", number];
    }
}

@end

