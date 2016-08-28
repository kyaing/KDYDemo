//
//  WBStatusHelper.h
//  KDYDemo
//
//  Created by zhongye on 15/12/25.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：微博工具类

#import <Foundation/Foundation.h>

@interface WBStatusHelper : NSObject

///缩短数量描述，例如 51234 -> 5万
+ (NSString *)shortedNumberDesc:(NSUInteger)number;

/// 将微博API提供的图片URL转换成可用的实际URL
+ (NSURL *)defaultURLForImageURL:(id)imageURL;

///圆角头像的 manager
+ (YYWebImageManager *)avatarImageManager;

///从path创建图片 (有缓存)
+ (UIImage *)imageWithPath:(NSString *)path;

///将 date 格式化成微博的友好显示
+ (NSString *)stringWithTimelineDate:(NSString *)date;

///At正则 例如 @王思聪
+ (NSRegularExpression *)regexAt;

///话题正则 例如 #暖暖环游世界#
+ (NSRegularExpression *)regexTopic;

///表情正则 例如 [偷笑]
+ (NSRegularExpression *)regexEmoticon;

///表情字典 key:[偷笑] value:ImagePath
+ (NSDictionary *)emoticonDic;

///微博表情 Array<WBEmotionGroup> (实际应该做成动态更新的)
+ (NSArray *)emoticonGroups;

@end

