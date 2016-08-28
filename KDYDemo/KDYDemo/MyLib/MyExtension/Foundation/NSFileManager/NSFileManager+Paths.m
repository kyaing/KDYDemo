//
//  NSFileManager+Paths.m
//  KDYDemo
//
//  Created by zhongye on 16/3/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "NSFileManager+Paths.h"

@implementation NSFileManager (Paths)

+ (NSString *)pathForDirectory:(NSSearchPathDirectory)directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSString *)ky_getDocumentsPath {
    return [self pathForDirectory:NSDocumentDirectory];
}

+ (NSString *)ky_getLibraryPath {
    return [self pathForDirectory:NSLibraryDirectory];
}

+ (NSString *)ky_getCachesPath {
    return [self pathForDirectory:NSCachesDirectory];
}

@end

