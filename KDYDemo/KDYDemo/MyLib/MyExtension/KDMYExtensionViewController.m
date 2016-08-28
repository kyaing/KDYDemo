//
//  KDMyExtensionViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/2/23.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDMyExtensionViewController.h"

@interface KDMyExtensionViewController ()

@end

@implementation KDMyExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"扩展实例";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
    [self setupObjects];
}

- (void)setupViews {
    //Button1
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"测试事件" forState:UIControlStateNormal];
    [btn1 ky_setBackgroundColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    btn1.myString = @"3232323";
    NSLog(@"______%@", btn1.myString);
    
    [btn1 ky_addTargetAction:^(NSInteger tag) {
        NSLog(@"UIButton+block扩展");
    }];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    //Button2
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"登录" forState:UIControlStateNormal];
    [btn2 ky_setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    //在block内，使用实例对象，也要防止循环引用
    __weak UIButton *weakButton = btn2;
    [btn2 ky_addTargetAction:^(NSInteger tag) {
        [weakButton ky_showBtnIndicator];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [weakButton ky_hideBtnIndicator];
        });
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1);
        make.left.equalTo(btn1.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    //Button3
    UIButton *btn3 = [UIButton new];
    [btn3 setTitle:@"计时" forState:UIControlStateNormal];
    [btn3 ky_setBackgroundColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    __weak UIButton *weakBtn3 = btn3;
    [btn3 ky_addTargetAction:^(NSInteger tag) {
        [weakBtn3 ky_startTime:10 title:@"开始" waitTittle:@"结束"];
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn2.mas_right).offset(10);
        make.top.equalTo(btn1);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    //UITextView
    UITextView *textView = [UITextView new];
    textView.backgroundColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textView];

    //添加placeholder
    [textView addTextViewPlaceholder:@"UITextView_Placeholder"];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(10);
        make.left.equalTo(btn1);
        make.right.equalTo(btn3);
        make.height.mas_equalTo(38);
    }];
    
    //为UIView添加圆角
    UIView *myView = [UIView new];
    myView.frame = CGRectMake(10, 160, 50, 50);
    myView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myView];
    
    [myView ky_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecognizer) {
        NSLog(@"tap atcion");
    }];
    
    //这里还只能用frame布局，要不然得不到矩形框中的Size
    [myView ky_addViewCornerRadius:10
                       borderWidth:0.5
                           bgColor:[UIColor redColor]
                       borderColor:[UIColor clearColor]];
    
    //为UIImageView添加圆角
    UIImageView *myImageView = [UIImageView new];
    myImageView.frame = CGRectMake(80, 160, 100, 100);
    myImageView.image = [UIImage imageNamed:@"doge"];
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    myImageView.userInteractionEnabled = YES;
    [self.view addSubview:myImageView];
    
    [myImageView ky_addCornerRadius:10];
    [myImageView ky_addLongActionWithBlock:^(UIGestureRecognizer *gestureRecognizer) {
        NSLog(@"long actoin");
    }];
}

- (void)setupObjects {
    NSArray *array1 = @[@"ab", @"cd", @"ef", @"gg"];
    [array1 ky_eachObject:^(id object) {
        NSLog(@"___object:%@", object);
    }];
    
    [array1 ky_eachObjectWithIndex:^(id object, NSInteger index) {
        NSLog(@"___object:%@, index = %ld", object, (long)index);
    }];
    
    //    NSArray *array2 = @[@"ab", @"cd"];
    //    NSArray *tmp = [array2 filter:^BOOL(id object) {
    //        return array1;
    //    }];
    
    //m[NSArray ky_swizzleSelector:@selector(lastObject) withIMP:)];
}

@end

