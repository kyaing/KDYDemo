//
//  TimeChatTableCell.m
//  KDYDemo
//
//  Created by zhongye on 16/2/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "TimeChatTableCell.h"

@interface TimeChatTableCell () {
    UILabel *timeLabel;
}

@end

@implementation TimeChatTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //时间标签
        timeLabel = [UILabel new];
        timeLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textColor = [UIColor colorWithRed:0.341 green:0.369 blue:0.357 alpha:1];
        timeLabel.numberOfLines = 0;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.layer.cornerRadius = 5.f;
        timeLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:timeLabel];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(@80);
        }];
    }
    
    return self;
}

- (void)setModel:(ChatModel *)model {
    _model = model;
    timeLabel.text = model.timeStamp;
}

@end

