//
//  TestViewManager.m
//  KDYDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "TestViewManager.h"

@implementation TestViewManager

- (instancetype)init {
    self = [super init];
    if (self) {
        TestView *testView = [[TestView alloc] init];
        testView.frame = CGRectMake(0, 0, 0, 0);
        
        __weak typeof(testView) weakSelf = testView;
        testView.clickBtnBlock = ^() {
            weakSelf.testLabel.text = self.testModel.content;
            NSLog(@"点击按钮========");
        };
        
        self.testView = testView;
    }
    
    return self;
}

@end

