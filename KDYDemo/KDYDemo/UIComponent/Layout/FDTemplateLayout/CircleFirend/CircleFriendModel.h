//
//  CircleFriendModel.h
//  KDYDemo
//
//  Created by zhongye on 16/1/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleFriendModel : NSObject

@property (nonatomic, copy, readonly) NSString *avator;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic, copy) NSString *comment;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

