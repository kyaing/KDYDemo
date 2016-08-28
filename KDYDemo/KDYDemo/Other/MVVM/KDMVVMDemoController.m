//
//  KDMVVMDemoController.m
//  KDYDemo
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDMVVMDemoController.h"
#import "KDMVVMViewController.h"
//#import "KDRACDemoController.h"

@interface KDMVVMDemoController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *chartTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDMVVMDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图表的绘制";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chartTableView];
}

#pragma mark - Getter/Setter
- (UITableView *)chartTableView {
    if (!_chartTableView) {
        _chartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _chartTableView.backgroundColor = [UIColor whiteColor];
        _chartTableView.delegate = self;
        _chartTableView.dataSource = self;
        
        //添加一个空白的view作为footerView
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        _chartTableView.tableFooterView = view;
    }
    
    return _chartTableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] initWithObjects:@"1. MVVM实践",
                    @"2. ReactiveCocoa实践",
                    nil];
    }
    
    return _dataArr;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[KDMVVMViewController new] animated:YES];
    } else {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
