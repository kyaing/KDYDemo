//
//  KDMVVMViewController.m
//  KDYDemo
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

/**
 开放的API接口：http://ajita.iteye.com/blog/2188914
 */

#import "KDMVVMViewController.h"
#import "TestViewModel.h"
#import "TestViewManager.h"

@interface KDMVVMViewController ()

@property (nonatomic, strong) UIButton        *clickButton;
@property (nonatomic, strong) TestViewModel   *viewModel;
@property (nonatomic, strong) TestViewManager *viewManager;
@property (nonatomic, strong) UITableView     *mvvmTableView;

@end

@implementation KDMVVMViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MVVMDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self.clickButton addTarget:self action:@selector(loadDataBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clickButton];
    
    self.mvvmTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mvvmTableView.delegate = self;
    self.mvvmTableView.dataSource = self;
    [self.view addSubview:self.mvvmTableView];
    
    [self.mvvmTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.clickButton = [UIButton new];
    [self.clickButton bk_addEventHandler:^(id sender) {
        //在viewModel，请求网络加载数据
        [self.viewModel getDataListSuccess:^{
            self.viewManager.testModel = [self.viewModel getTestDatas];
            [self.mvvmTableView reloadData];
            
        } failure:^{
            //当请求数据失败后，显示相应的失败图
            //...
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Event Response
//- (void)loadDataBtnAction {
//    //在viewModel，请求网络加载数据
//    [self.viewModel getDataListSuccess:^{
//        self.viewManager.testModel = [self.viewModel getTestDatas];
//        
//    } failure:^{
//        
//    }];
//}

#pragma mark - Getter/Setter
- (TestViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TestViewModel alloc] init];
    }
    
    return _viewModel;
}

- (TestViewManager *)viewManager {
    if (_viewManager == nil) {
        _viewManager = [[TestViewManager alloc] init];
    }
    
    return _viewManager;
}

@end

