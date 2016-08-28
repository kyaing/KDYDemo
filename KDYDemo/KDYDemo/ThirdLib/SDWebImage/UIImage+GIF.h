//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIF)

#pragma mark ****** 从NSData获取Gif图片 ******
/**
 从NSData获取Gif图片
 */
+(UIImage *)sd_animatedGIFWithData:(NSData *)data;


#pragma mark ****** 从名字获取Gif图片 ******
/**
 从名字获取Gif图片
 */
+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;


#pragma mark ****** 从截取名字(如:8bed8f052d384a00b82975ea76bf383f.gif)获取Gif图片 ******
/**
 从名字获取Gif图片
 */
+(UIImage *)sd_PartiGifNamed:(NSString *)name;


#pragma mark ****** 从路径截取名字(如:/.../Documents/Ali/8bed8f052d384a00b82975ea76bf383f.gif)获取Gif图片 ******
/**
 从名字获取Gif图片
 /.../Documents/Ali/8bed8f052d384a00b82975ea76bf383f.gif
 */
+(UIImage *)sd_PathPartiGifNamed:(NSString *)name;

#pragma mark ****** 通过GifNamed和GifUrl加载Gif图片 ******
/**
 通过GifNamed和GifUrl加载Gif图片
 */
+ (UIImage *)sd_animatedEnUrl:(NSString *)EnUrl WithEmotEnDirectory:(NSString*)EnDirectory;



#pragma mark ****** 重新设置Gif图片的大小 ******
/**
 重新设置Gif图片的大小
 */
-(UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
