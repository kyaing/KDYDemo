//
//  ContactModel.h
//  KDYDemo
//
//  Created by zhongye on 15/12/8.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//
//  描述：联系人模型

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property (nonatomic, copy) NSString  *avatorUrl;  /** 头像 */
@property (nonatomic, copy) NSString  *userName;   /** 用户名 */

@end

