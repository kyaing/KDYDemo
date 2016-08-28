//
//  ChatModel.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/31.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _isSender = dic[@"isSender"];
        _content = dic[@"content"];
        _chatCellType = dic[@"chatCellType"];
        _timeStamp = dic[@"time"];
        _headImageURL = dic[@"avator"];
        _imageViewURL = dic[@"imageName"];
    }
    
    return self;
}

@end

