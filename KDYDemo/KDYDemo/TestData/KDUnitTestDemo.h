//
//  KDUnitTestDemo.h
//  KDYDemo
//
//  Created by kaideyi on 16/2/27.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDUnitTestDemo : NSObject

+ (KDUnitTestDemo *)sharedInstance;
- (NSInteger)addCounts:(NSInteger)a withB:(NSInteger)b;

@end

