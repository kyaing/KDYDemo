//
//  CircleFriendModel.m
//  KDYDemo
//
//  Created by zhongye on 16/1/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CircleFriendModel.h"

@implementation CircleFriendModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        _avator = dic[@"avator"];
        _content = dic[@"content"];
        _username = dic[@"username"];
        _time = dic[@"time"];
        _imageName = dic[@"imageName"];
        _comment = dic[@"comment"];
    }
    
    return self;
}

@end

