//
//  WBNewModel.h
//  KDYDemo
//
//  Created by kaideyi on 16/1/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 用户（user）
 返回值字段	字段类型	字段说明
 id         int64	用户UID
 idstr      string	字符串型的用户UID
 screen_name	string	用户昵称
 name       string	友好显示名称
 province	int	用户所在省级ID
 city       int	用户所在城市ID
 location	string	用户所在地
 description	string	用户个人描述
 url        string	用户博客地址
 profile_image_url	string	用户头像地址（中图），50×50像素
 profile_url	string	用户的微博统一URL地址
 domain	string	用户的个性化域名
 weihao	string	用户的微号
 gender	string	性别，m：男、f：女、n：未知
 followers_count	int	粉丝数
 friends_count	int	关注数
 statuses_count	int	微博数
 favourites_count	int	收藏数
 created_at	string	用户创建（注册）时间
 following	boolean	暂未支持
 allow_all_act_msg	boolean	是否允许所有人给我发私信，true：是，false：否
 geo_enabled	boolean	是否允许标识用户的地理位置，true：是，false：否
 verified	boolean	是否是微博认证用户，即加V用户，true：是，false：否
 verified_type	int	暂未支持
 remark	string	用户备注信息，只有在查询用户关系时才返回此字段
 status	object	用户的最近一条微博信息字段 详细
 allow_all_comment	boolean	是否允许所有人对我的微博进行评论，true：是，false：否
 avatar_large	string	用户头像地址（大图），180×180像素
 avatar_hd	string	用户头像地址（高清），高清头像原图
 verified_reason	string	认证原因
 follow_me	boolean	该用户是否关注当前登录用户，true：是，false：否
 online_status	int	用户的在线状态，0：不在线、1：在线
 bi_followers_count	int	用户的互粉数
 lang	string	用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
 */

@interface WBNewUserModel : NSObject
@property (nonatomic, copy) NSString    *idStr;             // 字符串型的用户UID
@property (nonatomic, copy) NSString    *screen_name;       // 用户昵称
@property (nonatomic, copy) NSString    *name;              // 友好显示名称
@property (nonatomic, copy) NSString    *location;          // 用户所在地
@property (nonatomic, copy) NSString    *descriptions;      // 用户个人描述
@property (nonatomic, copy) NSString    *url;               // 用户博客地址
@property (nonatomic, copy) NSString    *avatar_url;        // 用户头像地址，50×50像素
@property (nonatomic, copy) NSString    *avatar_large_url;  // 用户大头像地址
@property (nonatomic, copy) NSString    *gender;            // 性别，m：男、f：女、n：未知
@property (nonatomic, retain) NSNumber  *followers_count;   // 粉丝数
@property (nonatomic, retain) NSNumber  *friends_count;     // 关注数
@property (nonatomic, retain) NSNumber  *statuses_count;    // 微博数
@property (nonatomic, retain) NSNumber  *favourites_count;  // 收藏数
@property (nonatomic, retain) NSNumber  *verified;          // 是否是微博认证用户，即加V用户，true：是，false：否

@end

/*
 created_at	string	微博创建时间
 id         int64	微博ID
 mid	int64	微博MID
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 favorited	boolean	是否已收藏，true：是，false：否
 truncated	boolean	是否被截断，true：是，false：否
 in_reply_to_status_id	string	回复ID
 in_reply_to_user_id	string	回复人UID
 in_reply_to_screen_name	string	回复人昵称
 pic_urls       object  返回的图片数组
 thumbnail_pic	string	缩略图片，没有时不返回此字段
 bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
 original_pic	string	原始图片地址，没有时不返回此字段
 geo	object	地理信息字段 详细
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 mlevel	int	暂未支持
 visible	object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 */

@interface WBNewStatusModel : NSObject
@property (nonatomic,copy) NSString           *createDate;        // 微博的创建时间
@property (nonatomic,copy) NSNumber           *weiboId;           // 微博id
@property (nonatomic,copy) NSString           *weiboText;         // 微博内容
@property (nonatomic,copy) NSString           *source;            // 微博来源
@property (nonatomic,retain) NSNumber         *favorited;         // 是否已收藏，true：是，false：否
@property (nonatomic,copy) NSString           *thumbnailImage;    // 缩略图片地址，没有时不返回此字段
@property (nonatomic,copy) NSString           *bmiddleImage;      // 中等尺寸图片地址，没有时不返回此字段
@property (nonatomic,copy) NSString           *originalImage;     // 原始图片地址，没有时不返回此字段
@property (nonatomic,retain) NSDictionary     *geo;               // 地理信息字段
@property (nonatomic,retain) WBNewStatusModel *relWeibo;          // 被转发的原微博
@property (nonatomic,retain) WBNewUserModel   *user;              // 微博的作者用户
@property (nonatomic,retain) NSNumber         *repostsCount;      // 转发数
@property (nonatomic,retain) NSNumber         *commentsCount;     // 评论数

@end

