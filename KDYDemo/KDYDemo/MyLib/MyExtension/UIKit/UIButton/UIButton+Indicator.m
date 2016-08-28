//
//  UIButton+Indicator.m
//  KDYDemo
//
//  Created by zhongye on 16/2/23.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "UIButton+Indicator.h"

static void const *kButtonTitleTextKey = &kButtonTitleTextKey;
static void const *kIndicatorViewKey   = &kIndicatorViewKey;

@implementation UIButton (Indicator)

- (void)ky_showBtnIndicator {
    //创建指示器
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self addSubview:indicator];
    
    //指示器转动
    [indicator startAnimating];
    
    //按钮的title
    NSString *titleStr = self.titleLabel.text;
    
    //关联对象
    objc_setAssociatedObject(self, kButtonTitleTextKey, titleStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //显示指示器过程中，将title置空，并且不可用
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
}

- (void)ky_hideBtnIndicator {
    //获取对象
    NSString *titleStr = (NSString *)objc_getAssociatedObject(self, kButtonTitleTextKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, kIndicatorViewKey);
    
    [indicator removeFromSuperview];
    
    [self setTitle:titleStr forState:UIControlStateNormal];
    self.enabled = YES;
}

@end

