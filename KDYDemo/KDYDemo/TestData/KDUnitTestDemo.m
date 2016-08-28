//
//  KDUnitTestDemo.m
//  KDYDemo
//
//  Created by kaideyi on 16/2/27.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDUnitTestDemo.h"

@implementation KDUnitTestDemo

+ (KDUnitTestDemo *)sharedInstance {
    static KDUnitTestDemo *testUnitDemo = nil;
    dispatch_once_t oncen;
    dispatch_once(&oncen, ^{
        testUnitDemo = [KDUnitTestDemo new];
    });
    
    return testUnitDemo;
}

- (NSInteger)addCounts:(NSInteger)a withB:(NSInteger)b {
    return a + b;
}

@end

