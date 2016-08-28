//
//  NSObject+Swizzling.m
//  KDYDemo
//
//  Created by zhongye on 16/3/9.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "NSObject+Swizzling.h"

@implementation NSObject (Swizzling)

+ (IMP)ky_swizzleSelector:(SEL)origSelector withIMP:(IMP)newIMP {
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class, origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    
    if (!class_addMethod(self, origSelector, newIMP, method_getTypeEncoding(origMethod))) {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}

@end

