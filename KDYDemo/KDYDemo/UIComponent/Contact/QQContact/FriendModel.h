//
//  FriendModel.h
//  KDYDemo
//
//  Created by kaideyi on 15/12/9.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：好友模型

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

/** 好友图标 */
@property (nonatomic, copy) NSString *icon;
/** 好友介绍 */
@property (nonatomic, copy) NSString *intro;
/** 好友名称*/
@property (nonatomic, copy) NSString *name;
/** 是否是vip */
@property (nonatomic, getter = isVip) BOOL vip;

+ (instancetype)friendWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

