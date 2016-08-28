//
//  ChatKeyboardBar.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/31.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "ChatKeyboardBar.h"

@interface ChatKeyboardBar () <UITextViewDelegate> {
    /**
     *  TextView和自己底部约束，会被动态增加、删除
     */
    NSLayoutConstraint *bottomConstraintTextView;
    
    /**
     *  自己和父控件 底部约束，使用这个约束让自己伴随键盘移动
     */
    NSLayoutConstraint *bottomConstraintWithSupView;
    
    /**
     *  TextView的高度
     */
    CGFloat heightTextView;
}

@property (nonatomic, strong) UIButton    *voiceButton;     //语音按钮
@property (nonatomic, strong) UITextView  *inputTextView;   //输入框
@property (nonatomic, strong) UIButton    *faceButton;      //表情按钮
@property (nonatomic, strong) UIButton    *moreButton;      //插件按钮

@end

@implementation ChatKeyboardBar

#pragma mark - Getter
- (UIButton *)voiceButton {
    if (_voiceButton == nil) {
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceButton.translatesAutoresizingMaskIntoConstraints = NO;
        _voiceButton.backgroundColor = [UIColor clearColor];
        [_voiceButton setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateHighlighted];
        [_voiceButton addTarget:self action:@selector(voiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _voiceButton;
}

- (UITextView *)inputTextView {
    if (_inputTextView == nil) {
        _inputTextView = [[UITextView alloc] init];
        _inputTextView.layer.cornerRadius = 4.f;
        _inputTextView.layer.masksToBounds = YES;
        _inputTextView.layer.borderWidth = 1.f;
        _inputTextView.layer.borderColor =  [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        _inputTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 4.0f);
        _inputTextView.contentInset = UIEdgeInsetsZero;
        _inputTextView.scrollEnabled = YES;
        _inputTextView.scrollsToTop = NO;
        _inputTextView.font = [UIFont systemFontOfSize:15];
        _inputTextView.textAlignment = NSTextAlignmentLeft;
        _inputTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
        _inputTextView.keyboardType = UIKeyboardTypeDefault;
        _inputTextView.returnKeyType = UIReturnKeyDefault;
        _inputTextView.delegate = self;
    }
    
    return _inputTextView;
}

- (UIButton *)faceButton {
    if (_faceButton == nil) {
        _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _faceButton.translatesAutoresizingMaskIntoConstraints = NO;
        _faceButton.backgroundColor = [UIColor clearColor];
        [_faceButton setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
        [_faceButton addTarget:self action:@selector(faceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _faceButton;
}

- (UIButton *)moreButton {
    if (_moreButton == nil) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.translatesAutoresizingMaskIntoConstraints = NO;
        _moreButton.backgroundColor = [UIColor clearColor];
        [_moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
        [_moreButton addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreButton;
}

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0.922 green:0.925 blue:0.929 alpha:1];
        
        //创建子控件
        [self setupViews];
        
        //设置控件约束
        [self setupConstraints];
    }
    
    return self;
}

- (void)setupViews {
    [self addSubview:self.voiceButton];
    [self addSubview:self.inputTextView];
    [self addSubview:self.faceButton];
    [self addSubview:self.moreButton];
    
    //伴随着键盘显示或隐藏时，底部的键盘条也随着改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNoti:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHideNoti:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupConstraints {
    //语音约束
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(3);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    //插件约束
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-3);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];

    //表情约束
    [self.faceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moreButton.mas_left);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    //输入框约束
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.voiceButton.mas_right).offset(3);
        make.right.equalTo(self.faceButton.mas_left).offset(-3);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(@35);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification
- (void)keyboardShowNoti:(NSNotification *)notification {
    
}

- (void)keyboardHideNoti:(NSNotification *)notification {
    
}

- (void)keyboardChangeNoti:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if (notification.name == UIKeyboardWillShowNotification) {
        bottomConstraintWithSupView.constant = -(keyboardEndFrame.size.height)-49;
        
    } else {
        bottomConstraintWithSupView.constant = 0;
    }
    
    [self.superview layoutIfNeeded];
    [UIView commitAnimations];
}

/**
 *  获取自己和父控件底部约束，控制该约束可以让自己伴随键盘移动
 */
- (void)updateConstraints {
    [super updateConstraints];
    
    if (!bottomConstraintWithSupView) {
        NSArray *constraints = self.superview.constraints;
        
        for (int index = (int)constraints.count-1; index>0; index--) {  //从末尾开始查找
            NSLayoutConstraint *constraint = constraints[index];
            
            if (constraint.firstItem == self &&
                constraint.firstAttribute == NSLayoutAttributeBottom &&
                constraint.secondAttribute == NSLayoutAttributeBottom) {  //获取自己和父控件底部约束
                bottomConstraintWithSupView = constraint;
                break;
            }
        }
    }
}

#pragma mark - UITextViewDelegate 
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    //计算输入框最小高度
    CGSize size = [textView sizeThatFits:CGSizeMake(textView.contentSize.width, 0)];
    CGFloat contentHeight;
    
    //输入框的高度不能超过最大高度
    if (size.height > 80) {
        contentHeight = 80;
        textView.scrollEnabled = YES;
        
    } else {
        contentHeight = size.height;
        textView.scrollEnabled = NO;
    }
    
    if (heightTextView != contentHeight) {
        heightTextView = contentHeight;  //重新设置自己的高度
        [self invalidateIntrinsicContentSize];
    }
}

#pragma mark - Response
/**
 *  语音、表情面板、插件面板来回切换，注意切换之间的样式的改变！
 */
- (void)voiceBtnClick {
    
}

- (void)faceBtnClick {
    
}

- (void)moreBtnClick {
    
}

@end

