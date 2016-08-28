//
//  FriendGroupModel.h
//  KDYDemo
//
//  Created by kaideyi on 15/12/9.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"

@interface FriendGroupModel : NSObject

/** 好友模型数组 */
@property (nonatomic, strong) NSArray  *friends;
/** 分组名称 */
@property (nonatomic, copy  ) NSString *name;
/** 好友在线人数 */
@property (nonatomic, assign) NSInteger online;
//是否打开分组，默认为NO
@property (nonatomic, getter = isOpened) BOOL opened;

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

