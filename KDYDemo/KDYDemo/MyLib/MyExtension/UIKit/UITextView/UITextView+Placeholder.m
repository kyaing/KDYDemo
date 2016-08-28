//
//  UITextView+Placeholder.m
//  KDYDemo
//
//  Created by zhongye on 16/2/24.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UITextView+Placeholder.h"

static void const *placeTextView = &placeTextView;

@interface UITextView () <UITextViewDelegate>
@property (nonatomic, strong) UITextView *placeHolderTextView;

@end

@implementation UITextView (Placeholder) 

- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, placeTextView);
}

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, placeTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addTextViewPlaceholder:(NSString *)placeholder {
    if (![self placeHolderTextView]) {
        self.delegate = self;
        
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeholder;
        [self addSubview:textView];
        
        [self setPlaceHolderTextView:textView];
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeHolderTextView.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}

@end

