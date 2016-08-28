//
//  UIView+GestureBlock.m
//  KDYDemo
//
//  Created by zhongye on 16/3/1.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UIView+GestureBlock.h"

static const void *kTapActionGestureKey = &kTapActionGestureKey;
static const void *kLongActionGestureKey = &kLongActionGestureKey;

static const void *kTapActionGestureBlockKey = &kTapActionGestureBlockKey;
static const void *kLongActionGestureBlockKey = &kLongActionGestureBlockKey;

@implementation UIView (GestureBlock)

//单击手势
- (void)ky_addTapActionWithBlock:(GestureActionBlock)block {
    UITapGestureRecognizer *tapGesture = objc_getAssociatedObject(self, kTapActionGestureKey);
    if (tapGesture == nil) {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureAction:)];
        [self addGestureRecognizer:tapGesture];
        
        objc_setAssociatedObject(self, kTapActionGestureKey, tapGesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    //关联block
    objc_setAssociatedObject(self, kTapActionGestureBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleTapGestureAction:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = (GestureActionBlock)objc_getAssociatedObject(self, kTapActionGestureBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

//长按手势
- (void)ky_addLongActionWithBlock:(GestureActionBlock)block {
    UILongPressGestureRecognizer *longGesture = objc_getAssociatedObject(self, kLongActionGestureKey);
    if (longGesture == nil) {
        longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGestureAction:)];
        [self addGestureRecognizer:longGesture];
        
        objc_setAssociatedObject(self, kLongActionGestureKey, longGesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    //关联block
    objc_setAssociatedObject(self, kLongActionGestureBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleLongGestureAction:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = (GestureActionBlock)objc_getAssociatedObject(self, kLongActionGestureBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

@end

