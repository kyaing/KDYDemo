//
//  WBCommentModel.m
//  KDYDemo
//
//  Created by zhongye on 16/2/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "WBCommentModel.h"
#import "WBDealing.h"

@implementation WBCommentModel

-(instancetype)initWithJsonDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        WSet_Dic_String_Key(dic,self.created_at,@"created_at");
        WSet_Dic_String_Key(dic,self.text,@"text");
        WSet_Dic_String_Key(dic,self.source,@"source");
        WSet_Dic_Obj_Key(dic,self.user,@"user");
        WSet_Dic_String_Key(dic,self.mid,@"mid");
        WSet_Dic_String_Key(dic,self.idstr,@"idstr");
        WSet_Dic_Obj_Key(dic,self.status,@"status");
        WSet_Dic_Obj_Key(dic,self.reply_comment,@"reply_comment");
    }
    return self;
}

@end

