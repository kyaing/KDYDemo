//
//  User.h
//  KDYDemo
//
//  Created by zhongye on 16/2/26.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (assign, readwrite, nonatomic) NSString *name;
@property (assign, readwrite, nonatomic) NSString *username2;

- (instancetype)init:(NSString *)username name:(NSString *)name;

@end

