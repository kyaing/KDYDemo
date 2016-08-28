//
//  KDTopScrollViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/10.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDTopScrollViewController.h"
#import "KDTXViewController.h"
#import "KDJRViewController.h"
#import "KDXMViewController.h"

@interface KDTopScrollViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDTopScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"顶部滚动条";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] initWithObjects:@"1. 腾讯视频",
                    @"2. 今日头条",
                    @"3. 喜马拉雅", nil];
    }
    
    return _dataArr;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idntifer = @"topCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idntifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idntifer];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    if (row == 0) {
        [self.navigationController pushViewController:[KDTXViewController new] animated:YES];
    } else if (row == 1) {
        [self.navigationController pushViewController:[KDJRViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[KDXMViewController new] animated:YES];
    }
}

@end

