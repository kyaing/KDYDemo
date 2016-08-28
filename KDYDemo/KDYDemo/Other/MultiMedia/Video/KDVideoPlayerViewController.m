//
//  KDVideoViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/3/9.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDVideoPlayerViewController.h"
#import "KDPlayerView.h"

@interface KDVideoPlayerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) KDPlayerView *playerView;
@property (nonatomic, strong) UITableView  *myTableView;

@end

@implementation KDVideoPlayerViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //视频播放器
    [self setupPlayerView];
    
    //播放器下面的内容
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //嵌入播放器的控制器，改变导航栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _playerView.videoURL = nil;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

#pragma mark - Private
- (void)setupPlayerView {
    self.playerView = [KDPlayerView new];
    [self.view addSubview:self.playerView];
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        //视频播放器的宽高比为16比9，这样也就适配了横竖屏比
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0/16.0);
    }];
    
    //接受播放器返回的block
    __weak typeof(self) weakSelf = self;
    self.playerView.backBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //设置本地播放的URL
    //    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"150511_JiveBike" withExtension:@"mov"];
    
    NSURL *videoURL = [NSURL URLWithString:@"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"];
    self.playerView.videoURL = videoURL;
}

- (void)setupTableView {
    self.myTableView = [[UITableView alloc] init];
    self.myTableView.backgroundColor = [UIColor lightGrayColor];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playerView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行数据", indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

