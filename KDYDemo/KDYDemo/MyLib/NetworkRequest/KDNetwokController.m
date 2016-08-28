//
//  KDNetwokController.m
//  KDYDemo
//
//  Created by zhongye on 16/2/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDNetwokController.h"

#define Baidu_ApiKey @"ad895dc35e2868cf59774822ce194176"

@interface KDNetwokController ()

@end

@implementation KDNetwokController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"网络请求";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *url = @"http://apis.baidu.com/baidunuomi/openapi/shopdeals";
    [KDNetworking configCommonHttpHeaders:[NSDictionary dictionaryWithObject:Baidu_ApiKey forKey:@"apikey"]];
    
    //测试GET API
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"1745896" forKey:@"shop_id"];
    [KDNetworking getWithUrl:url params:params success:^(id response) {
        NSLog(@"response = %@", response);
    } fail:^(NSError *error) {
        
    }];
}

@end

