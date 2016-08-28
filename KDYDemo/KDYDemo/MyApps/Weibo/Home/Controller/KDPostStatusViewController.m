//
//  KDPostStatusViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/31.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDPostStatusViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"

@interface KDPostStatusViewController ()
@property (nonatomic, strong) SinaWeibo *sinaWeibo;

@end

@implementation KDPostStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _sinaWeibo = delegate.sinaweibo;
    
    [self postStatusData];
}

#pragma mark - Data Request 
- (void)postStatusData {
    NSString *textStr = @"test";
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:textStr forKey:@"status"];

    __weak KDPostStatusViewController *weakSelf = self;
    [_sinaWeibo requestWithURL:@"statuses/upload"
                        params:params
                    httpMethod:@"POST"
                         block:^(NSDictionary *result) {
                             [weakSelf getPostWeiboData:result];
                         }];
}

- (void)getPostWeiboData:(NSDictionary *)result {
    NSLog(@"%@", result);
}


@end

