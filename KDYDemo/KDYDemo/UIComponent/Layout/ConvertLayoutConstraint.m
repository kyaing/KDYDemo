//
//  ConvertLayoutConstraint.m
//  KDYDemo
//
//  Created by kaideyi on 16/8/27.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "ConvertLayoutConstraint.h"

@implementation ConvertLayoutConstraint

+ (instancetype)sharedInstance {
    static ConvertLayoutConstraint *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [ConvertLayoutConstraint new];
        _instance->_deviceType = [_instance getCurrentDeviceType];
    });
    
    return _instance;
}

+ (CGFloat)getConstraintWithValue:(CGFloat)value {
    ConvertLayoutConstraint *convertLayout = [self sharedInstance];
    CGFloat constraint = 0.f;
    
    switch (convertLayout.deviceType) {
        case kDeviceType_6p:
            constraint = (CGFloat)(value / 3);
            break;
            
        case kDevieType_6:
            constraint = (CGFloat)((value * 0.60335196f) / 2);
            break;
            
        default:
            constraint = (CGFloat)((value * 0.51396648f) / 2);
            break;
    }
    
    return constraint;
}

+ (UIFont *)getAdjustFont:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:[self getAdjustFontSize:fontSize]];
}

+ (CGFloat)getAdjustFontSize:(CGFloat)fontSize {
    ConvertLayoutConstraint *convertLayout = [self sharedInstance];
    CGFloat size = 0.f;
 
    switch (convertLayout.deviceType) {
    case kDeviceType_6p:
        size = fontSize;
        break;
        
    case kDevieType_6:
        size = (fontSize * kDevie6FontScale);
        break;
        
    default:
        size = (fontSize * kDevie5sFontScale);
        break;
    }
    
    return size;
}

/**
 *  当前设备的类型
 */
- (kDeviceType)getCurrentDeviceType {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (screenHeight == 480.f) {
        return kDeviceType_4s;
    } else if (screenHeight == 568.f) {
        return kDevieType_5s;
    } else if (screenHeight == 667.f) {
        return kDevieType_6;
    } else {
        return kDeviceType_6p;
    }
    
    return 0;
}

@end

