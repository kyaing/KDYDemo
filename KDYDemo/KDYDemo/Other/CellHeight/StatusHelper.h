//
//  StatusHelper.h
//  KDYDemo
//
//  Created by kaideyi on 16/3/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellHeightModel.h"

/**
 *  针对富文本中需要特殊处理的帮助类
 */
@interface StatusHelper : NSObject

/// 微博图片 cache
+ (YYMemoryCache *)imageCache;

/**
 *  从path创建图片(有缓存)
 *
 *  @param path 图片的路径
 *
 *  @return 图片
 */
+ (UIImage *)imageWithPath:(NSString *)path;

/**
 *  匹配@用户名
 *
 *  @return 正则表达式regex
 */
+ (NSRegularExpression *)regexAt;

/**
 *  匹配链接
 *
 *  @return 正则表达式regex
 */
+ (NSRegularExpression *)regexWeb;

/**
 *  匹配表情
 *
 *  @return 正则表达式regex
 */
+ (NSRegularExpression *)regexEmotion;

/**
 *  表情字典 key:[偷笑] value:ImagePath
 *
 *  @return 返回字典
 */
+ (NSDictionary *)emoticonDic;

/// 微博表情 Array<WBEmotionGroup> (实际应该做成动态更新的)
//+ (NSArray<WBEmoticonGroup *> *)emoticonGroups;

@end

