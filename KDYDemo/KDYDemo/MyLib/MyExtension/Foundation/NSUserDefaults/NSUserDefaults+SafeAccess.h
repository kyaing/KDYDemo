//
//  NSUserDefaults+SafeAccess.h
//  KDYDemo
//
//  Created by zhongye on 16/3/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  本地存储操作(适合于存储简单的数据)
 *  NSUserDefaults支持的数据类型有：NSNumber(NSInteger、float、double), NSString, NSDate, NSArray, NSDictionary, BOOL
 *  并且NSUserDefaults存储是对象全是不可变的
 */
@interface NSUserDefaults (SafeAccess)

#pragma mark - Read 
+ (NSString *)ky_stringForKey:(NSString *)defaultName;

+ (NSArray *)ky_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)ky_dictionaryForKey:(NSString *)defaultName;

+ (NSInteger)ky_integerForKey:(NSString *)defaultName;

+ (BOOL)ky_boolForKey:(NSString *)defaultName;

+ (float)ky_floatForKey:(NSString *)defaultName;

+ (NSURL *)ky_URLForKey:(NSString *)defaultName;

//使用反归档
+ (id)ky_arcObjectForKey:(NSString *)defaultName;

#pragma mark - Wirte
+ (void)ky_setObject:(id)value forKey:(NSString *)defaultName;

//使用归档(存储有组织的数据)
+ (void)ky_arcSetObject:(id)value forKey:(NSString *)defaultName;

@end

