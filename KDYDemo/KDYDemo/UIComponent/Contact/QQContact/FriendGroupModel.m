//
//  FriendGroupModel.m
//  KDYDemo
//
//  Created by kaideyi on 15/12/9.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "FriendGroupModel.h"

@implementation FriendGroupModel

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in _friends) {
            FriendModel *friend = [FriendModel friendWithDict:dict];
            [tempArray addObject:friend];
        }
        _friends = tempArray;
    }
    
    return self;
}

@end

