//
//  KDCoreTextViewController.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDCoreTextViewController.h"
#import "CoreTextView.h"
#import "CoreImageTextView.h"
#import "CoreTextEmojiView.h"

@interface KDCoreTextViewController ()
@property (nonatomic, copy  ) NSString          *className;
@property (nonatomic, strong) CoreTextView      *coreTextView;
@property (nonatomic, strong) CoreImageTextView *coreImageTextView;
@property (nonatomic, strong) CoreTextEmojiView *coreTextEmojiView;

@end

@implementation KDCoreTextViewController

- (instancetype)initWithTextClassName:(NSString *)className {
    if (self = [super init]) {
        _className = className;
    }
    
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = _className;
    self.view.backgroundColor = [UIColor whiteColor];
    
    Class myClass = NSClassFromString(_className);
    NSLog(@"%@", myClass);
    
    if (myClass == [CoreTextView class]) {
        self.coreTextView = [CoreTextView new];
        _coreTextView.backgroundColor = [UIColor lightGrayColor];
        _coreTextView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
        [self.view addSubview:_coreTextView];
        
    } else if (myClass == [CoreImageTextView class]) {
        self.coreImageTextView = [CoreImageTextView new];
        _coreImageTextView.backgroundColor = [UIColor lightGrayColor];
        _coreImageTextView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
        [self.view addSubview:_coreImageTextView];
        
    } else if (myClass == [CoreTextEmojiView class]) {
        self.coreTextEmojiView = [CoreTextEmojiView new];
        _coreTextEmojiView.backgroundColor = [UIColor lightGrayColor];
        _coreTextEmojiView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
        [self.view addSubview:_coreTextEmojiView];
    }
}

@end

