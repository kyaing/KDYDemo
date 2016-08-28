//
//  NSArray+Block.m
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "NSArray+Block.h"

@implementation NSArray (Block)

- (void)ky_eachObject:(void (^)(id))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block) {
            block(obj);
        }
    }];
}

- (void)ky_eachObjectWithIndex:(void (^)(id, NSInteger))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (block) {
            block(obj, idx);
        }
    }];
}

- (NSArray *)ky_filter:(BOOL (^)(id))block {
    //数据筛选，必然会用到NSPredicate类，其中block必须返回YES/NO(表示匹配或不匹配)，evaluatedObject表示数组成员
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary<NSString *,id> *bindings) {
        return block(evaluatedObject);
    }]];
}

@end

