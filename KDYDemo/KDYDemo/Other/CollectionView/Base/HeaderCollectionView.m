//
//  HeaderCollectionReusableView.m
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "HeaderCollectionView.h"

@implementation HeaderCollectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(0, 0, self.width, self.height);
        lable.text = @"headerView";
        lable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lable];
        
        _headerLabel = lable;
    }
    
    return self;
}

@end

