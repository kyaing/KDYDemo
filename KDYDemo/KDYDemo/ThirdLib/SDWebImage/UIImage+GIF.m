//
//  UIImage+GIF.m
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImage+GIF.h"
#import <ImageIO/ImageIO.h>
//#import "EmoticonManage.h"

@implementation UIImage (GIF)


#pragma mark ****** 从NSData获取Gif图片 ******
/**
 从NSData获取Gif图片
 */
+ (UIImage *)sd_animatedGIFWithData:(NSData *)data
{
    if (!data)
    {
        return nil;
    }

    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);

    size_t count = CGImageSourceGetCount(source);

    UIImage *animatedImage;

    if (count <= 1)
    {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else
    {
        NSMutableArray *images = [NSMutableArray array];

        NSTimeInterval duration = 0.0f;

        for (size_t i = 0; i < count; i++)
        {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);

            duration += [self sd_frameDurationAtIndex:i source:source];

            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];

            CGImageRelease(image);
        }

        if (!duration)
        {
            duration = (1.0f / 10.0f) * count;
        }

        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }

    CFRelease(source);

    return animatedImage;
}



#pragma mark ****** 通过GifNamed和GifUrl加载Gif图片 ******
/**
 通过GifNamed和GifUrl加载Gif图片
 */
//+ (UIImage *)sd_animatedEnUrl:(NSString *)EnUrl WithEmotEnDirectory:(NSString*)EnDirectory
//{
//    //保存路径
//    NSString *GifNameFilePath = [NSString stringWithFormat:@"%@/%@",HomeDirectoryDocumentFilePath,EnDirectory];
//    //临时存储图片
//    UIImage *TempImage = [self sd_PartiGifNamed:GifNameFilePath];
//    NSData *TempEmData;
//    if (TempImage == nil)
//    {
//        NSLog(@"EnUrl:%@",EnUrl);
//        TempEmData = [NSData dataWithContentsOfURL:[NSURL URLWithString:EnUrl]];
//        TempImage = [self sd_animatedGIFWithData:TempEmData];
//        
//        //如果保存成功的话,就更新数据库为已经下载
//        if ([[EmoticonManage sharedInstance] WriteToFileWithName:GifNameFilePath WithFileData:TempEmData])
//        {
//            [[SQLiteDBManage sharedInstance] UpdateEmoticonTableWithEnUrl:EnUrl WithBuy:@"未购买" WithWithPackageId:@"没有PackageId" Withtype:1];
//
//        }
//    }
//    
//    
//    return TempImage;
//
//}



+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source
{
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];

    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {

        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }

    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.

    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }

    CFRelease(cfFrameProperties);
    return frameDuration;
}


#pragma mark ****** 从名字获取Gif图片 ******
/**
 从名字获取Gif图片
 */
+ (UIImage *)sd_animatedGIFNamed:(NSString *)name
{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f)
    {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];

        NSData *data = [NSData dataWithContentsOfFile:retinaPath];

        if (data)
        {
            return [UIImage sd_animatedGIFWithData:data];
        }

        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];

        data = [NSData dataWithContentsOfFile:path];

        if (data)
        {
            return [UIImage sd_animatedGIFWithData:data];
        }

        return [UIImage imageNamed:name];
    }
    else
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];

        NSData *data = [NSData dataWithContentsOfFile:path];

        if (data)
        {
            return [UIImage sd_animatedGIFWithData:data];
        }

        return [UIImage imageNamed:name];
    }
}



#pragma mark ****** 从截取名字(如:8bed8f052d384a00b82975ea76bf383f.gif)获取Gif图片 ******
/**
 从截取名字(如:8bed8f052d384a00b82975ea76bf383f.gif)获取Gif图片
 */
+ (UIImage *)sd_PartiGifNamed:(NSString *)name
{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f)
    {
        NSData *data = [NSData dataWithContentsOfFile:name];
        
        if (data)
        {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else
    {
        
        NSData *data = [NSData dataWithContentsOfFile:name];
        
        if (data)
        {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}



#pragma mark ****** 从路径截取名字(如:/.../Documents/Ali/8bed8f052d384a00b82975ea76bf383f.gif)获取Gif图片 ******
/**
 从名字获取Gif图片
 /.../Documents/Ali/8bed8f052d384a00b82975ea76bf383f.gif
 */
+(UIImage *)sd_PathPartiGifNamed:(NSString*)name
{
//    name = [NSString stringWithFormat:@"%@/%@",HomeDirectoryDocumentFilePath,name];
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 1.0f)
    {
        NSData *data = [NSData dataWithContentsOfFile:name];
        
        if (data)
        {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else
    {
        NSData *data = [NSData dataWithContentsOfFile:name];
        
        if (data)
        {
            return [UIImage sd_animatedGIFWithData:data];
        }
        return [UIImage imageNamed:name];
    }
}






#pragma mark ****** 重新设置Gif图片的大小 ******
/**
 重新设置Gif图片的大小
 */
- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size
{
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero))
    {
        return self;
    }

    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;

    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;

    if (widthFactor > heightFactor)
    {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    }
    else if (widthFactor < heightFactor)
    {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }

    NSMutableArray *scaledImages = [NSMutableArray array];

    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);

    for (UIImage *image in self.images)
    {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

        [scaledImages addObject:newImage];
    }

    UIGraphicsEndImageContext();

    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

@end
