//
//  NSArray+Block.h
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Block)

/**
 *  遍历数组中的元素
 */
- (void)ky_eachObject:(void (^)(id object))block;
- (void)ky_eachObjectWithIndex:(void (^)(id object, NSInteger index))block;

/**
 *  过滤数组的元素
 *
 *  @param block blcok
 *
 *  @return 返回符合条件的数组 
 */
- (NSArray *)ky_filter:(BOOL (^)(id object))block;

@end

