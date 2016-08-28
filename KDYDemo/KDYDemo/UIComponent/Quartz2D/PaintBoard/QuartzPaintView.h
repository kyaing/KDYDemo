//
//  QuartzPaintView.h
//  KDYDemo
//
//  Created by zhongye on 16/1/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuartzPaintView : UIView
@property (nonatomic, strong) NSMutableArray  *linesArray;
@property (nonatomic, strong) CAShapeLayer    *myShapeLayer;
@property (nonatomic, strong) UIBezierPath    *myBezierPath;

@end

