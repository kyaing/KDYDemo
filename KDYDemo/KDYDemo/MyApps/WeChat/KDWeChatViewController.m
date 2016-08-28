//
//  KDWeChatViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/12.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDWeChatViewController.h"
#import "KDWeHomeViewController.h"
#import "KDWeContactViewController.h"
#import "KDWeDiscoveryViewController.h"
#import "KDWeMeViewController.h"

@interface KDWeChatViewController ()

@end

@implementation KDWeChatViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"kaideyi";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置子控制器
    [self setupChildsVC];
}

//创建子控制器
- (void)setupChildsVC {
    KDWeHomeViewController *homeVC = [KDWeHomeViewController new];
    homeVC.view.backgroundColor = [UIColor whiteColor];
    
    KDWeContactViewController *contactVC = [KDWeContactViewController new];
    contactVC.view.backgroundColor = [UIColor whiteColor];
    
    KDWeDiscoveryViewController *discoveryVC = [KDWeDiscoveryViewController new];
    discoveryVC.view.backgroundColor = [UIColor whiteColor];
    
    KDWeMeViewController *meVC = [KDWeMeViewController new];
    meVC.view.backgroundColor = [UIColor whiteColor];
    
    [self addOneChildVC:homeVC title:@"微信" imageName:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];
    [self addOneChildVC:contactVC title:@"通讯录" imageName:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL"];
    [self addOneChildVC:discoveryVC title:@"发现" imageName:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];
    [self addOneChildVC:meVC title:@"我" imageName:@"tabbar_me" selectedImage:@"tabbar_meHL"];
    
    self.viewControllers = @[homeVC, contactVC, discoveryVC, meVC];
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
    selectTextAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:14/255.0 green:180/255.0 blue:0 alpha:1];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttr forState:UIControlStateSelected];
    
    //tabbar会重新渲染图片，所以要重新设置选择图片的模式
    UIImage *selectedImg = [UIImage imageNamed:selectedImage];
    selectedImg = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImg;
    
    ZYNavigationController *navigationVC = [[ZYNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navigationVC];
}

@end

