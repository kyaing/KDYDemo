//
//  KDAttributedViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/2/17.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDAttributedViewController.h"
#import "CTDisplayView.h"
#import "CTFrameParseConfig.h"

@interface KDAttributedViewController ()

@property (nonatomic, strong) CTDisplayView *displayView;

@end

@implementation KDAttributedViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"图文混排";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)setupViews {
    _displayView = [CTDisplayView new];
    _displayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_displayView];
    
    [_displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 200));
    }];
    
    CTFrameParseConfig *config = [[CTFrameParseConfig alloc] init];
    config.textColor = [UIColor redColor];
    config.width = self.displayView.width;
    
    CoreTextData *data = [CTFrameParse parseContent:@"按照以上原则，我们将`CTDisplayView`中的部分内容拆开。" config:config];
    self.displayView.data = data;
    self.displayView.height = data.height;
    self.displayView.backgroundColor = [UIColor yellowColor];
}

@end

