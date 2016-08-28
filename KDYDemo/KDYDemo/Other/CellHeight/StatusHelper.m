//
//  StatusHelper.m
//  KDYDemo
//
//  Created by kaideyi on 16/3/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "StatusHelper.h"

#define kRegexAt      @"@[-_a-zA-Z0-9\u4E00-\u9FA5]+"
#define kRegexEmo     @"\\[[^ \\[\\]]+?\\]"
#define kRegexWeb     @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"

@implementation StatusHelper

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
        // 查找 @2x @3x 的图片
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

+ (NSRegularExpression *)regexAt {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kRegexAt options:kNilOptions error:nil];
    return regex;
}

+ (NSRegularExpression *)regexWeb {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kRegexWeb options:kNilOptions error:nil];
    return regex;
}

+ (NSRegularExpression *)regexEmotion {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kRegexEmo options:kNilOptions error:nil];
    return regex;
}

+ (NSDictionary *)emoticonDic {
    NSString *emoticonBundlePath = [[NSBundle mainBundle] pathForResource:@"EmoticonWeibo" ofType:@"bundle"];
    NSMutableDictionary *dic = [self _emoticonDicFromPath:emoticonBundlePath];
    
    return dic;
}

+ (NSMutableDictionary *)_emoticonDicFromPath:(NSString *)path {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    WBEmoticonGroup *group = nil;
    
    NSString *jsonPath = [path stringByAppendingPathComponent:@"info.json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    if (data.length) {
        group = [WBEmoticonGroup modelWithJSON:data];
    }
    
    if (!group) {
        NSString *plistPath = [path stringByAppendingPathComponent:@"info.plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        if (plist.count) {
            group = [WBEmoticonGroup modelWithJSON:plist];
        }
    }
    
    for (WBEmoticon *emoticon in group.emoticons) {
        if (emoticon.png.length == 0) continue;
        NSString *pngPath = [path stringByAppendingPathComponent:emoticon.png];
        if (emoticon.chs) dic[emoticon.chs] = pngPath;
        if (emoticon.cht) dic[emoticon.cht] = pngPath;
    }
    
    NSArray *folders = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *folder in folders) {
        if (folder.length == 0) continue;
        NSDictionary *subDic = [self _emoticonDicFromPath:[path stringByAppendingPathComponent:folder]];
        if (subDic) {
            [dic addEntriesFromDictionary:subDic];
        }
    }
    
    return dic;
}

//+ (NSArray<WBEmoticonGroup *> *)emoticonGroups {
//    static NSMutableArray *groups;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSString *emoticonBundlePath = [[NSBundle mainBundle] pathForResource:@"EmoticonWeibo" ofType:@"bundle"];
//        NSString *emoticonPlistPath = [emoticonBundlePath stringByAppendingPathComponent:@"emoticons.plist"];
//        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:emoticonPlistPath];
//        NSArray *packages = plist[@"packages"];
//        groups = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[WBEmoticonGroup class] json:packages];
//        
//        NSMutableDictionary *groupDic = [NSMutableDictionary new];
//        for (int i = 0, max = (int)groups.count; i < max; i++) {
//            WBEmoticonGroup *group = groups[i];
//            if (group.groupID.length == 0) {
//                [groups removeObjectAtIndex:i];
//                i--;
//                max--;
//                continue;
//            }
//            NSString *path = [emoticonBundlePath stringByAppendingPathComponent:group.groupID];
//            NSString *infoPlistPath = [path stringByAppendingPathComponent:@"info.plist"];
//            NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
//            [group yy_modelSetWithDictionary:info];
//            if (group.emoticons.count == 0) {
//                i--;
//                max--;
//                continue;
//            }
//            groupDic[group.groupID] = group;
//        }
//        
//        NSArray<NSString *> *additionals = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[emoticonBundlePath stringByAppendingPathComponent:@"additional"] error:nil];
//        for (NSString *path in additionals) {
//            WBEmoticonGroup *group = groupDic[path];
//            if (!group) continue;
//            NSString *infoJSONPath = [[[emoticonBundlePath stringByAppendingPathComponent:@"additional"] stringByAppendingPathComponent:path] stringByAppendingPathComponent:@"info.json"];
//            NSData *infoJSON = [NSData dataWithContentsOfFile:infoJSONPath];
//            WBEmoticonGroup *addGroup = [WBEmoticonGroup yy_modelWithJSON:infoJSON];
//            if (addGroup.emoticons.count) {
//                for (WBEmoticon *emoticon in addGroup.emoticons) {
//                    emoticon.group = group;
//                }
//                [((NSMutableArray *)group.emoticons) insertObjects:addGroup.emoticons atIndex:0];
//            }
//        }
//    });
//    
//    return groups;
//}

/*
 weibo.app 里面的正则(取自YYKit中)：
 
 HTTP链接 (例如 http://www.weibo.com ):
 ([hH]ttp[s]{0,1})://[a-zA-Z0-9\.\-]+\.([a-zA-Z]{2,4})(:\d+)?(/[a-zA-Z0-9\-~!@#$%^&*+?:_/=<>.',;]*)?
 ([hH]ttp[s]{0,1})://[a-zA-Z0-9\.\-]+\.([a-zA-Z]{2,4})(:\d+)?(/[a-zA-Z0-9\-~!@#$%^&*+?:_/=<>]*)?
 (?i)https?://[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+([-A-Z0-9a-z_\$\.\+!\*\(\)/,:;@&=\?~#%]*)*
 ^http?://[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+(\/[\w-. \/\?%@&+=\u4e00-\u9fa5]*)?$
 
 链接 (例如 www.baidu.com/s?wd=test ):
 ^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+([-A-Z0-9a-z_\$\.\+!\*\(\)/,:;@&=\?~#%]*)*
 
 邮箱 (例如 sjobs@apple.com ):
 \b([a-zA-Z0-9%_.+\-]{1,32})@([a-zA-Z0-9.\-]+?\.[a-zA-Z]{2,6})\b
 \b([a-zA-Z0-9%_.+\-]+)@([a-zA-Z0-9.\-]+?\.[a-zA-Z]{2,6})\b
 ([a-zA-Z0-9%_.+\-]+)@([a-zA-Z0-9.\-]+?\.[a-zA-Z]{2,6})
 
 电话号码 (例如 18612345678):
 ^[1-9][0-9]{4,11}$
 
 At (例如 @王思聪 ):
 @([\x{4e00}-\x{9fa5}A-Za-z0-9_\-]+)
 
 话题 (例如 #奇葩说# ):
 #([^@]+?)#
 
 表情 (例如 [呵呵] ):
 \[([^ \[]*?)]
 
 匹配单个字符 (中英文数字下划线连字符)
 [\x{4e00}-\x{9fa5}A-Za-z0-9_\-]
 
 匹配回复 (例如 回复@王思聪: ):
 \x{56de}\x{590d}@([\x{4e00}-\x{9fa5}A-Za-z0-9_\-]+)(\x{0020}\x{7684}\x{8d5e})?:
 
 */

@end

