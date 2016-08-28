//
//  NSObject+Swizzling.h
//  KDYDemo
//
//  Created by zhongye on 16/3/9.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSObject的Swizzling应用
 */
@interface NSObject (Swizzling)

/**
 *  Swizzling
 *
 *  @param origSelector 原方法的方法的选择器
 *  @param newIMP       新方法的实现指针
 *
 *  @return 
 */
+ (IMP)ky_swizzleSelector:(SEL)origSelector withIMP:(IMP)newIMP;

@end

