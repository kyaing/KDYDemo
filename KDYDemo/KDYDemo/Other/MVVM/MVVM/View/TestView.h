//
//  TestView.h
//  KDYDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickBtnBlock) ();
typedef void (^pushBtnBlock) ();

@interface TestView : UIView

@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) UIButton *pushBtn;
@property (nonatomic, strong) UILabel  *testLabel;

@property (nonatomic, strong) clickBtnBlock clickBtnBlock;
@property (nonatomic, strong) pushBtnBlock  pushBtnBlock;

@end

