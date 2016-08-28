//
//  CellHeightModel.m
//  KDYDemo
//
//  Created by zhongye on 16/3/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CellHeightModel.h"

@implementation CellHeightModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        _avator = dic[@"avator"];
        _content = dic[@"content"];
        _username = dic[@"username"];
        _time = dic[@"time"];
        _imageName = dic[@"imageName"];
        _comment = dic[@"comment"];
    }
    
    return self;
}

@end

@implementation WBEmoticon

+ (NSArray *)modelPropertyBlacklist {
    return @[@"group"];
}

@end

@implementation WBEmoticonGroup

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"groupID" : @"id",
             @"nameCN" : @"group_name_cn",
             @"nameEN" : @"group_name_en",
             @"nameTW" : @"group_name_tw",
             @"displayOnly" : @"display_only",
             @"groupType" : @"group_type"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"emoticons" : [WBEmoticon class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [_emoticons enumerateObjectsUsingBlock:^(WBEmoticon *emoticon, NSUInteger idx, BOOL *stop) {
        emoticon.group = self;
    }];
    
    return YES;
}

@end

