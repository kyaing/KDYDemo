//
//  KDChartViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/1.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDChartViewController.h"
#import "KDCircleChartViewController.h"

@interface KDChartViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *chartTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDChartViewController

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
        _dataArr = [[NSMutableArray alloc] initWithObjects:@"1. Circle Chart",
                    @"2. Line Chart",
                    @"3. Pie Chart",
                    @"4. Bar Chart",
                    @"5. Scatter Chart", nil];
    }
    
    return _dataArr;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"chartCell";
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
        [self.navigationController pushViewController:[KDCircleChartViewController new] animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end

