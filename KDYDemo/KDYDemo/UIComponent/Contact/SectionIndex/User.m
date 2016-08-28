//
//  User.m
//  KDYDemo
//
//  Created by zhongye on 16/2/26.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)init:(NSString *)username name:(NSString *)name {
    self = [super init];
    self.username2 = username;
    self.name = name;
    
    return self;
}

@end

