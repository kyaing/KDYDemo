//
//  WBNewModel.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "WBNewModel.h"
#import "MJExtension.h"

@implementation WBNewUserModel

- (NSDictionary *)replacedKeyFromPropertyName {
    NSDictionary *mapAtt = @{
             @"idStr"               :@"idstr",
             @"screen_name"         :@"screen_name",
             @"name"                :@"name",
             @"location"            :@"location",
             @"descriptions"        :@"description",
             @"url"                 :@"url",
             @"avatar_url"          :@"avatar_large",
             @"avatar_large_url"    :@"avatar_hd",
             @"gender"              :@"gender",
             @"followers_count"     :@"followers_count",
             @"friends_count"       :@"friends_count",
             @"statuses_count"      :@"statuses_count",
             @"favourites_count"    :@"favourites_count",
             @"verified"            :@"verified"
             };
    
    return mapAtt;
}

@end

@implementation WBNewStatusModel

- (NSDictionary *)replacedKeyFromPropertyName {
    NSDictionary *mapAtt = @{
              @"createDate"       :@"created_at",
              @"weiboId"          :@"id",
              @"weiboText"        :@"text",
              @"source"           :@"source",
              @"favorited"        :@"favorited",
              @"thumbnailImage"   :@"thumbnail_pic",
              @"bmiddleImage"     :@"bmiddle_pic",
              @"originalImage"    :@"original_pic",
              @"geo"              :@"geo",
              @"repostsCount"     :@"reposts_count",
              @"commentsCount"    :@"comments_count"
              };
    
    return mapAtt;
}

@end

