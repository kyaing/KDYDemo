//
//  NSFileManager+Paths.h
//  KDYDemo
//
//  Created by zhongye on 16/3/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  获取APP中的沙盒目录路径(Documents/Library/Caches)
 */
@interface NSFileManager (Paths)

+ (NSString *)ky_getDocumentsPath;

+ (NSString *)ky_getLibraryPath;

+ (NSString *)ky_getCachesPath;

@end

