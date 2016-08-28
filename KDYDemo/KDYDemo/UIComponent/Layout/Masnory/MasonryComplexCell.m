//
//  MasonryComplexCell.m
//  KDYDemo
//
//  Created by zhongye on 16/1/28.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "MasonryComplexCell.h"

@interface MasonryComplexCell ()

@property (nonatomic, strong) UIImageView *avatarImage;  //头像
@property (nonatomic, strong) UILabel     *nameLabel;    //用户名
@property (nonatomic, strong) UILabel     *timeLabel;    //时间
@property (nonatomic, strong) UILabel     *bodyLabel;    //文本
@property (nonatomic, strong) UIImageView *photoImage;   //图片

/**
 * 针对不同的Cell类型，而特殊处理某些特殊的约束条件
 */
@property (nonatomic, strong) MASConstraint *bodyBottomConstraint;
@property (nonatomic, strong) MASConstraint *bodyHightConstraint;
@property (nonatomic, strong) MASConstraint *photoHightConstraint;
@property (nonatomic, strong) MASConstraint *photoTopConstraint;

@end

@implementation MasonryComplexCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置子控件
        [self setupViews];
        
        //设置约束
        [self setupMasConstraints];
    }
    
    return self;
}

- (void)setCellType:(ComplexCellType)cellType {
    //首先让约束失效
    [self.bodyHightConstraint deactivate];
    [self.photoHightConstraint deactivate];
    [self.bodyBottomConstraint deactivate];
    [self.photoTopConstraint deactivate];
    
    switch (cellType) {
        case ComplexCellTextType:
            [self.photoHightConstraint activate];
            [self.bodyBottomConstraint activate];
            break;
            
        case ComplexCellPhotoType:
            [self.bodyHightConstraint activate];
            [self.photoTopConstraint activate];
            break;
            
        case ComplexCellTextPhotoType:
            break;
            
        default:
            break;
    }
}

- (void)setupViews {
    //头像
    self.avatarImage = [UIImageView new];
    self.avatarImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.avatarImage];
    
    //用户名
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.backgroundColor = [UIColor greenColor];
    self.nameLabel.text = @"kaideyi";
    [self.contentView addSubview:self.nameLabel];
    
    //时间
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.backgroundColor = [UIColor orangeColor];
    self.timeLabel.text = @"2016-1-28 14:13:43";
    [self.contentView addSubview:self.timeLabel];

    //文本
    self.bodyLabel = [UILabel new];
    self.bodyLabel.text = @"测试文本，通过利用Masonry来设计复杂的Cell类。";
    self.bodyLabel.backgroundColor = [UIColor yellowColor];
    self.bodyLabel.font = [UIFont systemFontOfSize:18];
    self.bodyLabel.numberOfLines = 0;
    [self.contentView addSubview:self.bodyLabel];
    
    //图片
    self.photoImage = [UIImageView new];
    self.photoImage.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:self.photoImage];
}

- (void)setupMasConstraints {
    CGFloat spacing = 10.f;
    
    //头像
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(spacing, spacing, 0, 0));
        make.width.height.mas_equalTo(@45);
    }];
    
    //用户名
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage.mas_right).offset(spacing);
        make.right.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(spacing, 0, 0, spacing));
        make.height.mas_equalTo(@25);
    }];
    
    //时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(spacing * 0.5);
        make.right.equalTo(self.nameLabel.mas_right);
        make.height.mas_equalTo(@15);
    }];
    
    //文本
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImage.mas_bottom).offset(spacing);
        make.left.equalTo(self.timeLabel.mas_left);
        make.right.equalTo(self.timeLabel.mas_right);
        
        self.bodyHightConstraint = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
        [self.bodyHightConstraint deactivate];
        
        self.bodyBottomConstraint = make.bottom.equalTo(self.contentView).offset(-spacing);
        [self.bodyBottomConstraint deactivate];
    }];
    
    //图片
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(spacing);
        make.left.equalTo(self.bodyLabel.mas_left);
        make.right.equalTo(self.bodyLabel.mas_right);
        make.bottom.equalTo(self.contentView).offset(-10);
        
        self.photoHightConstraint = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
        [self.photoHightConstraint deactivate];
        
        self.photoTopConstraint = make.top.equalTo(self.avatarImage.mas_bottom).offset(spacing);
        [self.photoTopConstraint deactivate];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

+ (CGFloat)getCellsHeight:(ComplexCellType)cellType {
    switch (cellType) {
        case ComplexCellTextType:
            return 10 + 60 + 10 + 100 + 10;
            break;
        
        case ComplexCellPhotoType:
            return 10 + 60 + 10 + 150 + 10;
            break;
            
        case ComplexCellTextPhotoType:
            return 10 + 60 + 10 + 100 + 10 + 150 + 10;
            
        default:
            break;
    }
    
    return 0;
}

@end

