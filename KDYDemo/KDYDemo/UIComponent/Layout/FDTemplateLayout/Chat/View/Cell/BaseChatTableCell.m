//
//  ChatBaseTableCell.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/31.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "BaseChatTableCell.h"

@implementation BaseChatTableCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(320, 320, 320);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    //头像
    headImageView = [UIImageView new];
    headImageView.backgroundColor = [UIColor grayColor];
    headImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadGesture:)];
    [headImageView addGestureRecognizer:tapGesture];
    
    //气泡
    bubbleImageView = [UIImageView new];
    bubbleImageView.userInteractionEnabled = YES;

    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [bubbleImageView addGestureRecognizer:longGesture];
    
    [self.contentView addSubview:headImageView];
    [self.contentView addSubview:bubbleImageView];
}

- (void)setupConstraints {
    if (isSender) {    /** 发送方 */
        //加载气泡图片，要拉伸图片！
        bubbleImageView.image = [[UIImage imageNamed:kImageNameChat_Send_Nor] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        bubbleImageView.highlightedImage = [[UIImage imageNamed:kImageNameChat_Send_HL] stretchableImageWithLeftCapWidth:30 topCapHeight:30];

        //头像布局
        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 0, 0, 15));
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
     
        //气泡布局
        [bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImageView.mas_top);
            make.right.equalTo(headImageView.mas_left).offset(-5);
            make.bottom.equalTo(self.contentView).offset(-5);
            
            //设置气泡的最大宽度（保证文本可以在气泡中显示，并且又限制了它的宽度）
            make.width.lessThanOrEqualTo([NSNumber numberWithFloat:kScreenWidth * 0.7]);
        }];
        
    } else {    /** 接收方 */
        bubbleImageView.image = [[UIImage imageNamed:kImageNameChat_Recieve_Nor] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        bubbleImageView.highlightedImage = [[UIImage imageNamed:kImageNameChat_Recieve_HL] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        
        //头像布局
        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 15, 0, 0));
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        //气泡布局
        [bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImageView.mas_top);
            make.left.equalTo(headImageView.mas_left).offset(45);
            make.bottom.equalTo(self.contentView);
            make.width.lessThanOrEqualTo([NSNumber numberWithFloat:kScreenWidth * 0.7]);
        }];
    }
}

#pragma mark - Setter 
- (void)setModel:(ChatModel *)model {
    _model = model;
    
    isSender = [model.isSender boolValue];
    headImageView.image = [UIImage imageNamed:model.headImageURL];
    
    //设置约束(在得到数据model后再去设置)
    [self setupConstraints];
}

#pragma mark - Actions
- (void)tapHeadGesture:(UITapGestureRecognizer *)gesture {
    NSLog(@"点击了头像.");
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture {
    
}

//“长按手势”默认是不成为第一响应者的！
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end

