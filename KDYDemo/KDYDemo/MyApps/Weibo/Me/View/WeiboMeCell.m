//
//  WeiboMeCell.m
//  KDYDemo
//
//  Created by zhongye on 15/12/31.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "WeiboMeCell.h"

@implementation WeiboMeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor redColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

//- (void)awakeFromNib {
//    
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//}

@end

