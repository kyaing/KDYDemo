//
//  WBHomeTableViewCell.m
//  KDYDemo
//
//  Created by zhongye on 16/2/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "WBHomeTableViewCell.h"
#import "TYAttributedLabel.h"
#import "WBHeadView.h"
#import "WBImageContentView.h"
#import "WBBottomView.h"

@interface WBHomeTableViewCell () <TYAttributedLabelDelegate> {
    WBHeadView *_headView;
    TYAttributedLabel *_contentLabel;
    
    UIView *_retweetedView;
    TYAttributedLabel *_retweetedLabel;
    
    WBImageContentView *_imageContentView;
    WBBottomView *_bottomView;
}

@end

@implementation WBHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置子控件
        [self setupViews];
        
        //设置Key
        [self setupViewsKey];
        
        //设置约束
        [self setupMasConstraints];
    }
    
    return self;
}

- (void)setupViews {
    //关部视图(个人信息)
    
}

- (void)setupViewsKey {
    
}

- (void)setupMasConstraints {
    
}

- (void)drawCell {
    
}

@end

