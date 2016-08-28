//
//  KDYDemoTests.m
//  KDYDemoTests
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KDUnitTestDemo.h"

@interface KDYDemoTests : XCTestCase

@end

@implementation KDYDemoTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
   [super tearDown];
}

- (void)testExample {
    NSArray *array = [NSArray arrayWithObjects:@1, @2, @3, nil];
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"test.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    XCTAssertEqual(success, YES);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
}

- (void)testAddCount {
    NSInteger result = [[KDUnitTestDemo sharedInstance] addCounts:10 withB:10];
    XCTAssertEqual(result, 20);
}

@end

