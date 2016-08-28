//
//  WBStatusHelper.m
//  KDYDemo
//
//  Created by zhongye on 15/12/25.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "WBStatusHelper.h"
#import "WBModel.h"
#import "NSObject+YYModel.h"

@implementation WBStatusHelper
#pragma mark - 时间
+ (NSString *)shortedNumberDesc:(NSUInteger)number {
    if (number <= 9999) {
        return [NSString stringWithFormat:@"%ld", number];
    }
    
    if (number <= 9999999) {
        return [NSString stringWithFormat:@"%ld万", number/10000];
    }
    
    return [NSString stringWithFormat:@"%ld千万", number/10000000];
}

+ (NSString *)stringWithTimelineDate:(NSString *)date {
    if (!date) return @"";
    
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    //##这种方法没有得到正确的时间
    //    NSDate *now = [NSDate new];
    //    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    //    if (delta < -60 * 10) { // 本地时间有问题
    //        return [formatterFullDate stringFromDate:date];
    //    } else if (delta < 60 * 10) { // 10分钟内
    //        return @"刚刚";
    //    } else if (delta < 60 * 60) { // 1小时内
    //        return [NSString stringWithFormat:@"%d分钟前", (int)(delta / 60.0)];
    //    } else if (date.isToday) {
    //        return [NSString stringWithFormat:@"%d小时前", (int)(delta / 60.0 / 60.0)];
    //    } else if (date.isYesterday) {
    //        return [formatterYesterday stringFromDate:date];
    //    } else if (date.year == now.year) {
    //        return [formatterSameYear stringFromDate:date];
    //    } else {
    //        return [formatterFullDate stringFromDate:date];
    //    }
    
    /**
     微博返回时间格式：Tue Dec 29 14:27:16 +0800 2015  ->  EEE MMM d HH:mm:ss Z yyyy
     先把它转换成上而的格式；然后再把它转换为我们常用的格式：yyyy-MM-dd HH:mm:ss
     */
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
    NSDate *mydate = [formatter dateFromString:date];
    
    NSDateFormatter *myFormatter = [NSDateFormatter new];
    [myFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *myDateStr = [myFormatter stringFromDate:mydate];
    
    return myDateStr;
}

#pragma mark - 链接/图片
+ (NSURL *)defaultURLForImageURL:(id)imageURL {
    /*
     微博 API 提供的图片 URL 有时并不能直接用，需要做一些字符串替换：
     http://u1.sinaimg.cn/upload/2014/11/04/common_icon_membership_level6.png //input
     http://u1.sinaimg.cn/upload/2014/11/04/common_icon_membership_level6_default.png //output
     
     http://img.t.sinajs.cn/t6/skin/public/feed_cover/star_003_y.png?version=2015080302 //input
     http://img.t.sinajs.cn/t6/skin/public/feed_cover/star_003_os7.png?version=2015080302 //output
     */
    
    if (!imageURL) return nil;
    NSString *link = nil;
    if ([imageURL isKindOfClass:[NSURL class]]) {
        link = ((NSURL *)imageURL).absoluteString;
    } else if ([imageURL isKindOfClass:[NSString class]]) {
        link = imageURL;
    }
    if (link.length == 0) return nil;
    
    if ([link hasSuffix:@".png"]) {
        // add "_default"
        if (![link hasSuffix:@"_default.png"]) {
            NSString *sub = [link substringToIndex:link.length - 4];
            link = [sub stringByAppendingFormat:@"_default.png"];
        }
    } else {
        // replace "_y.png" with "_os7.png"
        NSRange range = [link rangeOfString:@"_y.png?version"];
        if (range.location != NSNotFound) {
            NSMutableString *mutable = link.mutableCopy;
            [mutable replaceCharactersInRange:NSMakeRange(range.location + 1, 1) withString:@"os7"];
            link = mutable;
        }
    }
    
    return [NSURL URLWithString:link];
}

+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"weibo.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            return [image imageByRoundCornerRadius:100]; // a large value
        };
    });
    
    return manager;
}

+ (YYMemoryCache *)imageCache {
    static YYMemoryCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [YYMemoryCache new];
        cache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        cache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
        cache.name = @"WeiboImageCache";
    });
    
    return cache;
}

+ (UIImage *)imageWithPath:(NSString *)path {
    if (!path) return nil;
    UIImage *image = [[self imageCache] objectForKey:path];
    if (image) return image;
    if (path.pathScale == 1) {
        //查找 @2x @3x 的图片
        NSArray *scales = [NSBundle preferredScales];
        for (NSNumber *scale in scales) {
            image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathScale:scale.floatValue]];
            if (image) break;
        }
    } else {
        image = [UIImage imageWithContentsOfFile:path];
    }
    if (image) {
        image = [image imageByDecoded];
        [[self imageCache] setObject:image forKey:path];
    }
    
    return image;
}

#pragma mark - @At/#话题#/[表情]
+ (NSRegularExpression *)regexAt {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //微博的 At 只允许 英文数字下划线连字符，和 unicode 4E00~9FA5 范围内的中文字符，这里保持和微博一致。。
        //目前中文字符范围比这个大
        regex = [NSRegularExpression regularExpressionWithPattern:@"@[-_a-zA-Z0-9\u4E00-\u9FA5]+" options:kNilOptions error:NULL];
    });
    
    return regex;
}

+ (NSRegularExpression *)regexTopic {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"#[^@#]+?#" options:kNilOptions error:NULL];
    });
    
    return regex;
}

+ (NSRegularExpression *)regexEmoticon {
    static NSRegularExpression *regular;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regular = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
    });
    
    return regular;
}

+ (NSDictionary *)emoticonDic {
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emotionBundlePath = [[NSBundle mainBundle] pathForResource:@"EmoticonWeibo" ofType:@"bundle"];
        //单例中不能调用成员方法，而是类方法
        dic = [self _emotionDicFromPath:emotionBundlePath];
    });
    
    return dic;
}

+ (NSMutableDictionary *)_emotionDicFromPath:(NSString *)path {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    WBEmotionGroup *group = nil;
    NSString *jsonPath = [path stringByAppendingPathComponent:@"info.json"];
    NSData *json = [NSData dataWithContentsOfFile:jsonPath];
    if (json.length) {
        group = [WBEmotionGroup modelWithJSON:json];
    }
    
    if (!group) {
        NSString *plistPath = [path stringByAppendingPathComponent:@"info.plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        if (plist.count) {
            group = [WBEmotionGroup modelWithJSON:plist];
        }
    }
    
    for (WBEmotion *emoticon in group.emoticons) {
        if (emoticon.png.length == 0) continue;
        NSString *pngPath = [path stringByAppendingPathComponent:emoticon.png];
        if (emoticon.chs) dic[emoticon.chs] = pngPath;
        if (emoticon.cht) dic[emoticon.cht] = pngPath;
    }
    
    NSArray *folders = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *folder in folders) {
        if (folder.length == 0) continue;
        NSDictionary *subDic = [self _emotionDicFromPath:[path stringByAppendingPathComponent:folder]];
        if (subDic) {
            [dic addEntriesFromDictionary:subDic];
        }
    }
    
    return dic;
}

+ (NSArray *)emoticonGroups {
    return nil;
}

@end

