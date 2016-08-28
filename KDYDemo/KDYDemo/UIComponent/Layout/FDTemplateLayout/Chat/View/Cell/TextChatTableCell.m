//
//  TextChatTableCell.m
//  KDYDemo
//
//  Created by zhongye on 16/2/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "TextChatTableCell.h"

@interface TextChatTableCell () {
    UILabel *contentLabel;
}

@end

@implementation TextChatTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //文本内容
        contentLabel = [UILabel new];
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.numberOfLines = 0;
        [bubbleImageView addSubview:contentLabel];
        
        //文本布局（注意它的内边距好像并不是一样的数值）
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bubbleImageView.mas_top).offset(10);
            make.left.equalTo(bubbleImageView.mas_left).offset(15);
            make.right.equalTo(bubbleImageView.mas_right).offset(-15);
            make.bottom.equalTo(bubbleImageView.mas_bottom).offset(-20);
        }];
    }
    
    return self;
}

- (void)setModel:(ChatModel *)model {
    contentLabel.text = model.content;
    [super setModel:model];
}

#pragma mark - Gesture
/**
 *  长按文本出现菜单：复制、转发、删除、更多
 *
 *  @param gesture 长按手势
 */
- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //成为第一响应者
        [self becomeFirstResponder];
        bubbleImageView.highlighted = YES;
        
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMenu:)];
        UIMenuItem *retweet = [[UIMenuItem alloc]initWithTitle:@"转发" action:@selector(retweetMenu:)];
        UIMenuItem *remove = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(removeMenu:)];
        UIMenuItem *more = [[UIMenuItem alloc]initWithTitle:@"更多" action:@selector(moreMenu:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[copy, retweet, remove, more]];
        [menu setTargetRect:bubbleImageView.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillHide) name:UIMenuControllerWillHideMenuNotification object:nil];
    }
}

- (void)menuControllerWillHide {
    bubbleImageView.highlighted = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//实现自己想要的MenuItem
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return  ((action == @selector(copyMenu:))   || (action == @selector(retweetMenu:))  ||
             (action == @selector(removeMenu:)) || (action == @selector(moreMenu:)));
}

#pragma mark - UIMenuController
- (void)copyMenu:(id)sender {

}

- (void)retweetMenu:(id)sender {
    
}

- (void)removeMenu:(id)sender {
    
}

- (void)moreMenu:(id)sender {
    
}

@end

