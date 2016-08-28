//
//  FrameHeightCell.m
//  KDYDemo
//
//  Created by zhongye on 16/3/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "FrameHeightCell.h"

#define kFrameCellNameFont     16
#define KFrameCellTimeFont     13

@interface FrameHeightCell ()

/** 头像 */
@property (nonatomic, strong) UIImageView *avatorImage;

/** 昵称 */
@property (nonatomic, strong) UILabel     *nameLabel;

/** 时间 */
@property (nonatomic, strong) UILabel     *timeLabel;

/** 正文内容(富文本) */
@property (nonatomic, strong) YYLabel     *textlabel;

@end

@implementation FrameHeightCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建子视图
        [self setupViews];
    }
    
    return self;
}

/**
 *  这里简单模仿下微博的正文部分，
 *  实际过程中，要抽出并封装好相应的子视图。现在只有个控件：头像、昵称、时间、正文。
 */
- (void)setupViews {
    @weakify(self);
    
    //头像
    self.avatorImage = [[UIImageView alloc] init];
    _avatorImage.backgroundColor = [UIColor lightGrayColor];
    _avatorImage.frame = CGRectMake(10, 10, 50, 50);
    _avatorImage.layer.cornerRadius = 5.f;
    _avatorImage.layer.masksToBounds = YES;
    _avatorImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _avatorImage.layer.borderWidth = 0.2;
    [self.contentView addSubview:_avatorImage];
    
    //昵称
    self.nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_avatorImage.frame)+10, CGRectGetMinY(_avatorImage.frame), 200, 15);
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = [UIFont systemFontOfSize:kFrameCellNameFont];
    _nameLabel.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_nameLabel];
    
    //时间
    self.timeLabel = [[UILabel alloc] init];
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_avatorImage.frame) + 10, CGRectGetMaxY(_nameLabel.frame) + 5, 200, 15);
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont systemFontOfSize:KFrameCellTimeFont];
    _timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_timeLabel];
    
    //正文内容(YYText，后面几个参数还不清楚意义)
    self.textlabel = [[YYLabel alloc] init];
    _textlabel.backgroundColor = RGB(245, 245, 245);
    _textlabel.top = CGRectGetMaxY(_timeLabel.frame) + 5;
    _textlabel.left = CGRectGetMinX(_timeLabel.frame);
    _textlabel.width = kScreenWidth - 80;
    _textlabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _textlabel.displaysAsynchronously = YES;
    _textlabel.ignoreCommonProperties = YES;
    _textlabel.fadeOnAsynchronouslyDisplay = YES;
    _textlabel.fadeOnHighlight = YES;
    //@用户名；Web；#事件#；相应的点击事件处理
    _textlabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        if ([weak_self.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
            [weak_self.delegate cell:weak_self didClickInLabel:(YYLabel *)containerView textRange:range];
        }
    };
    [self.contentView addSubview:_textlabel];
}

#pragma mark - Layout
- (void)setLayout:(FrameHeightCellLayout *)layout {
    //以下的布局，在实际情况下也可都放于布局类中整体布局
    [_avatorImage sd_setImageWithURL:[NSURL URLWithString:layout.model.avator]];
    [_nameLabel setText:layout.model.username];
    [_timeLabel setText:layout.model.time];
    
    //设置富文本内容
    [_textlabel setTextLayout:layout.textLayout];
    _textlabel.height = layout.textHeight;
}

//+ (CGFloat)configureCellHeightWithModel:(CellHeightModel *)model {
//    CGFloat height = 0.f;
//    height += 10;
//    height += 40;
//    height += textHeight;
//    height += 5;
//    
//    return height;
//}

@end

