//
//  ImageChatTableCell.m
//  KDYDemo
//
//  Created by zhongye on 16/2/3.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "ImageChatTableCell.h"

@interface ImageChatTableCell () {
    UIImageView *imageView;
}

@end

@implementation ImageChatTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //图片
        imageView = [UIImageView new];
        imageView.layer.cornerRadius = 3.f;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [bubbleImageView addSubview:imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGesture:)];
        [imageView addGestureRecognizer:tapGesture];
    }
    
    return self;
}

- (void)setupImageConstraints {
    if (isSender) {
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bubbleImageView.mas_top).offset(5);
            make.left.equalTo(bubbleImageView.mas_left).offset(10);
            make.right.equalTo(bubbleImageView.mas_right).offset(-12);
            make.bottom.equalTo(bubbleImageView.mas_bottom).offset(-15);
        }];
        
    } else {
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bubbleImageView.mas_top).offset(5);
            make.left.equalTo(bubbleImageView.mas_left).offset(12);
            make.right.equalTo(bubbleImageView.mas_right).offset(-10);
            make.bottom.equalTo(bubbleImageView.mas_bottom).offset(-15);
        }];
    }
}

- (void)setModel:(ChatModel *)model {
    isSender = [model.isSender boolValue];
    imageView.image = [UIImage imageNamed:model.imageViewURL];
    
    [self setupImageConstraints];
    [super setModel:model];
}

#pragma mark - Gesture
/**
 *  单击查看图片
 *
 *  @param gesture 单击手势
 */
- (void)imageTapGesture:(UITapGestureRecognizer *)gesture {
    NSLog(@"imageTapGesture");
}

/**
 *  长按图片出现菜单：复制、删除
 *
 *  @param gesture 长按手势
 */
- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        bubbleImageView.highlighted = YES;
        
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMenu:)];
        UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMenu:)];
    
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[copy, delete]];
        [menu setTargetRect:bubbleImageView.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerHide) name:UIMenuControllerDidHideMenuNotification object:nil];
    }
}

- (void)menuControllerHide {
    bubbleImageView.highlighted = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return  (action == @selector(copyMenu:)) || (action == @selector(deleteMenu:));
}

- (void)copyMenu:(id)sender {
    
}

- (void)deleteMenu:(id)sender {
    
}

@end

