//
//  TestView.m
//  KDYDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    self.clickBtn = [UIButton new];
    [self.clickBtn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clickBtn];
    
    self.pushBtn = [UIButton new];
    [self.pushBtn addTarget:self action:@selector(pushBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.pushBtn];
}

- (void)clickBtnAction {
    if (self.clickBtnBlock) {
        self.clickBtnBlock();
    }
}

- (void)pushBtnAction {
    if (self.pushBtnBlock) {
        self.pushBtnBlock();
    }
}

@end

