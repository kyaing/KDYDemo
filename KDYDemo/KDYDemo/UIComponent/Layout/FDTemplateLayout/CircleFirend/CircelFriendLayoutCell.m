//
//  CircelFriendLayoutCell.m
//  KDYDemo
//
//  Created by zhongye on 16/1/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "CircelFriendLayoutCell.h"
#import "TYAttributedLabel.h"

#define CellSpaing 10.f
#define CellInsetSpacing 14.f

/**
 * 针对不同的Cell类型，特殊处理某些特殊的约束条件
 * Cell中的资源类型：文本、图片、小视频、及评论。
 * 这几种资源放在一起有以下几种组合：
    - 只有文本(没有图片)
    - 只有图片(没有文本)
    - 文本 + 图片
    - 文本 + 小视频
    - 以上四种类型 + 评论
 
 * 现在最大的问题，就是如何像Xib那样优雅地确定约束关系？！
 * 还是说，利用Masonry还是不熟练？
 *
 * 现在又有一个问题了：Masonry + FDTemplateLayoutCell的情况下，加上文本的图文混排是如何来计算高度的呢？
 * 即用了TYAttributedLabel是如何计算高度的；同时要是不用FD来自动算高，又将如何计算呢？
 * 在平时的开发中，多多看一些第三方的库是怎么写的，能否写一个集大成者的库：适应于 Frame / Autolayout; FD / 不用FD; OC / Swift.
 *
 * 使用TYAttributedLabel时，就是不显示正文部分；还有一个问题就是文本显示间距有点大，且行间距字间距设置为0时，还是不太紧凑。
 */

@interface CircelFriendLayoutCell ()

@property (nonatomic, strong) UIImageView *avatarImage;  //头像
@property (nonatomic, strong) UILabel     *nameLabel;    //用户名
@property (nonatomic, strong) UILabel     *bodyLabel;    //文本
//@property (nonatomic, strong) TYAttributedLabel *bodyLabel; //改用图文混排的方式

@property (nonatomic, strong) UIImageView *photoImage;   //图片
@property (nonatomic, strong) UILabel     *timeLabel;    //时间
@property (nonatomic, strong) UIButton    *commentBtn;   //评论按钮
@property (nonatomic, strong) UILabel     *commentLabel;

@property (nonatomic, strong) MASConstraint *bodyBottomConstraint;
@property (nonatomic, strong) MASConstraint *bodyHightConstraint;
@property (nonatomic, strong) MASConstraint *photoHightConstraint;
@property (nonatomic, strong) MASConstraint *photoTopConstraint;
@property (nonatomic, strong) MASConstraint *timeBottomConstraint;
@property (nonatomic, strong) MASConstraint *commentBottomConstraint;

@end

@implementation CircelFriendLayoutCell

#pragma mark - Life Cycle
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
    //头像
    self.avatarImage = [UIImageView new];
    self.avatarImage.backgroundColor = [UIColor grayColor];
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFit;
    
    //用户名
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:17];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor blueColor];
    
    //文本
    self.bodyLabel = [UILabel new];
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.font = [UIFont systemFontOfSize:16];
    //self.bodyLabel = [TYAttributedLabel new];
    
    //图片
    /**
     *  UIViewContentModeScaleAspectFit：保证了图片的全部显示，但是在UIImageView下会显示出空白，
     *  那么再加上UIViewContentModeLeft即保证了图片自适应的正确显示。
     */
    self.photoImage = [UIImageView new];
    self.photoImage.backgroundColor = [UIColor whiteColor];
    self.photoImage.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeLeft;
    
    //时间
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.text = @"3分钟前";
    self.timeLabel.textColor = [UIColor redColor];
    
    //评论按钮
    //问题：在某些情况下，如何在设置完按钮图片后，按钮的大小就是图片的大小呢
    self.commentBtn = [UIButton new];
    self.commentBtn.tag = self.indexPath.row;
    [self.commentBtn setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [self.commentBtn setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
    [self.commentBtn addTarget:self action:@selector(commentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //评论内容
    self.commentLabel = [UILabel new];
    self.commentLabel.font = [UIFont systemFontOfSize:14];
    self.commentLabel.textAlignment = NSTextAlignmentLeft;
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.textColor = [UIColor purpleColor];
    self.commentLabel.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.bodyLabel];
    [self.contentView addSubview:self.photoImage];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.commentLabel];
}

/**
 *  对Cell中的子控件进行布局
 */
- (void)setupMasConstraints {
    //头像布局
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(CellInsetSpacing, CellInsetSpacing, 0, 0));
        make.width.height.mas_equalTo(@40);
    }];
    
    //用户名布局
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage.mas_right).offset(CellSpaing);
        make.right.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(CellInsetSpacing, 0, 0, CellSpaing));
        make.height.mas_equalTo(@20);
    }];
    
    //文本布局
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CellSpaing * 0.5);
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.nameLabel.mas_right);
        
        //根据类型的不同来动态地改变控件某个约束
        self.bodyHightConstraint = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
        [self.bodyHightConstraint deactivate];
        
        self.bodyBottomConstraint = make.bottom.equalTo(self.timeLabel.mas_top).offset(-CellInsetSpacing);
        [self.bodyBottomConstraint deactivate];
    }];
    
    //图片布局
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(CellSpaing);
        make.left.equalTo(self.nameLabel.mas_left);
        //不能要图片的右边约束，这样UIImageView的大小就和图片的大小一致了
        //make.right.equalTo(self.nameLabel.mas_right);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-CellInsetSpacing);
        
        self.photoTopConstraint = make.top.equalTo(self.nameLabel.mas_bottom).offset(CellSpaing * 0.5);
        [self.photoTopConstraint deactivate];
    }];
    
    //时间布局
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoImage.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 10));
        
        self.timeBottomConstraint = make.bottom.equalTo(self.contentView).offset(-CellInsetSpacing);
        [self.timeBottomConstraint deactivate];
    }];
    
    //评论按钮布局
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 36));
        make.bottom.equalTo(self.contentView);
    }];
    
    //评论内容布局
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(CellSpaing * 0.8);
        make.left.equalTo(self.timeLabel.mas_left);
        make.right.equalTo(self.nameLabel.mas_right).multipliedBy(0.9);
        make.bottom.equalTo(self.contentView).offset(-CellSpaing);
    }];
}

/**
 *  设置控件的Key，方便调试约束冲突
 */
- (void)setupViewsKey {
    self.contentView.mas_key = @"_contentView";
    self.nameLabel.mas_key = @"_nameLabel";
    self.bodyLabel.mas_key = @"_bodyLabel";
    self.photoImage.mas_key = @"_photoImage";
    self.timeLabel.mas_key = @"_timeLabel";
}

#pragma mark - Getter
- (void)setCircleModel:(CircleFriendModel *)circleModel {
    _circleModel = circleModel;
 
    //先在设置数据前，统一使约束失效
    [self.photoTopConstraint deactivate];
    [self.bodyBottomConstraint deactivate];
    [self.bodyHightConstraint deactivate];
    [self.timeBottomConstraint deactivate];
    
    //需要根据Model中的值，来动态地调整某些约束
    NSString *avator = circleModel.avator;
    NSString *userName = circleModel.username;
    NSString *content = circleModel.content;
    NSString *photo = circleModel.imageName;
    NSString *comment = circleModel.comment;
    
    self.avatarImage.image = [UIImage imageNamed:avator];
    self.nameLabel.text = userName;
    
    /**
     *  Cell类型判断
     */
    if ([content isEqualToString:@""] && ![photo isEqualToString:@""]) {  //只有图片
        [self.bodyHightConstraint activate];
        [self.photoTopConstraint activate];
        
    } else if (![content isEqualToString:@""] && [photo isEqualToString:@""]) {  //只有文本
        [self.bodyBottomConstraint activate];
        [self.photoTopConstraint deactivate];
    }
    
    self.bodyLabel.text = content;
    //self.bodyLabel.textContainer = [self createTextContainer:_circleModel.content];
    
    self.photoImage.image = [UIImage imageNamed:photo];
    
    if ([comment isEqualToString:@""]) {  //没有评论
        [self.timeBottomConstraint activate];
    } else {
        self.commentLabel.text = comment;
    }
}

- (TYTextContainer *)createTextContainer:(NSString *)text {
    TYTextContainer *container = [TYTextContainer new];
    container.text = text;
    container.linesSpacing = 0;
    container.characterSpacing = 0;
    container.lineBreakMode = NSLineBreakByTruncatingTail;
    container = [container createTextContainerWithTextWidth:kScreenWidth - 14.0 - 40 - 20];
    
    return container;
}

#pragma mark - Events
- (void)commentBtnAction:(UIButton *)button {
    //更新评论内容，并且重新remark约束
    _circleModel.comment = @"增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容增加评论内容";
    
    [self.commentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(CellSpaing * 0.8);
        make.left.equalTo(self.timeLabel.mas_left);
        make.right.equalTo(self.nameLabel.mas_right).multipliedBy(0.9);
        make.bottom.equalTo(self.contentView).offset(-CellSpaing);
    }];
    
    //调用block，以刷新Cell
    if (self.block) {
        self.block();
    }
}

@end

