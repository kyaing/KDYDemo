//
//  MyPersonObject.
//  KDYDemo
//
//  Created by zhongye on 16/3/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  对象使用归档 (它就必须要支持NSCoding协议)
 *  但是有个问题：为什么要使用归档，什么时机用它会更好？
 */
@interface MyPersonObject : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, assign) NSInteger age;

- (NSString *)description;

@end

