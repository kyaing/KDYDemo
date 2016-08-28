//
//  UIButton+Block.m
//  KDYDemo
//
//  Created by zhongye on 16/2/23.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UIButton+Block.h"

static const void *buttonBlockKey = &buttonBlockKey;
static const void *stringKey = &stringKey;

@implementation UIButton (Block)

- (void)setMyString:(NSString *)myString {
    objc_setAssociatedObject(self, stringKey, myString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)myString {
    NSString *str = (NSString *)objc_getAssociatedObject(self, stringKey);
    return str;
}

- (void)ky_addTargetAction:(ActionBlock)actionBlock {
    //关联对象
    objc_setAssociatedObject(self, buttonBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionTouched:(UIButton *)button {
    //获取对象
    ActionBlock block = objc_getAssociatedObject(self, buttonBlockKey);
    
    __weak UIButton *weakButton = button;
    if (block) {
        block(weakButton.tag);
    }
}

@end
