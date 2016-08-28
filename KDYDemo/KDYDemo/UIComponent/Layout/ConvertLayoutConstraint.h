//
//  ConvertLayoutConstraint.h
//  KDYDemo
//
//  Created by kaideyi on 16/8/27.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDevie6FontScale  0.9
#define kDevie5sFontScale 0.7

//转换不同机型的约束
#define ConvertLayoutConstraint(constraint)     [ConvertLayoutConstraint getConstraintWithValue:constraint]

#define AdjustFontSize(size)                    [ConvertLayoutConstraint getAdjustFontSize:size]
#define AdjustFont(size)                        [ConvertLayoutConstraint getAdjustFont:size]

typedef NS_ENUM(NSUInteger, kDeviceType) {
    kDeviceType_4s,
    kDevieType_5s,
    kDevieType_6,
    kDeviceType_6p
};

/**
 *  以6p为原型转换6/5s/4s下的约束(物理尺寸)
 */
@interface ConvertLayoutConstraint : NSObject

@property (nonatomic, assign, readonly) kDeviceType deviceType;

+ (instancetype)sharedInstance;

/**
 *  以6p为原型转换成相应的约束
 *
 *  @param value 输入值
 *
 *  @return 转换后的值
 */
+ (CGFloat)getConstraintWithValue:(CGFloat)value;

/**
 *  得到相应的字体的字号大小
 */
+ (CGFloat)getAdjustFontSize:(CGFloat)fontSize;

/**
 *  得到相应的字体
 */
+ (UIFont *)getAdjustFont:(CGFloat)fontSize;

@end

