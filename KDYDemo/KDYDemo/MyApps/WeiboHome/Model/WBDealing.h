//
//  WBDealing.h
//  KDYDemo
//
//  Created by zhongye on 16/2/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#ifndef WBDealing_h
#define WBDealing_h

/**
 *  处理对象
 *
 *  @param dic 字典
 *  @param obj 属性名
 *  @param key key
 *
 *  @return
 */
#define WSet_Dic_Obj_Key(dic,obj,key) \
if([dic objectForKey:key]&&[dic objectForKey:key]!= [NSNull null]) obj = [dic objectForKey:key]; \
else obj=nil;

/**
 *  处理字符串
 *
 *  @param dic         字典
 *  @param string      属性名
 *  @param key         key
 *
 *  @return 值或者字符串
 */
#define WSet_Dic_String_Key(dic,string,key) \
if([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null]&& [[dic objectForKey:key] isKindOfClass:[NSString class]]) string = [dic objectForKey:key]; \
else string = @"";

/**
 *  处理长整形
 *
 *  @param dic 字典
 *  @param num 属性名
 *  @param key key
 *
 *  @return 值或者0
 */
#define WSet_Dic_Long_Long_Key(dic,num,key) \
if([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null]) num = [[dic objectForKey:key] longLongValue]; \
else num = 0;

/**
 *  处理int类型
 *
 *  @param dic 字典
 *  @param num 属性名
 *  @param key key
 *
 *  @return 值或者0
 */
#define WSet_Dic_Int_Key(dic,num,key) \
if([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null]) num = [[dic objectForKey:key] intValue]; \
else num = 0;

/**
 *  处理float类型
 *
 *  @param dic 字典
 *  @param num 属性名
 *  @param key key
 *
 *  @return 值或者0
 */
#define WSet_Dic_Float_Key(dic,num,key) \
if([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null]) num = [[dic objectForKey:key] floatValue]; \
else num = 0;

/**
 *  处理bool类型
 *
 *  @param dic 字典
 *  @param num 属性名
 *  @param key key
 *
 *  @return Yes 或者No
 */
#define WSet_Dic_Bool_Key(dic,num,key) \
if([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null]) num = [[dic objectForKey:key] boolValue]; \
else num = NO;

#endif /* WBDealing_h */

