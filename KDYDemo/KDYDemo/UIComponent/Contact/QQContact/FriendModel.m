//
//  FriendModel.m
//  KDYDemo
//
//  Created by kaideyi on 15/12/9.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

+ (instancetype)friendWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

@end

