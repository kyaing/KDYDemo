//
//  KDQuartz2DViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/5.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDQuartz2DViewController.h"
#import "KDShapeViewController.h"
#import "KDQuartzOtherViewController.h"
#import "KDPaintBoardViewController.h"
#import "KDContextViewController.h"

@interface KDQuartz2DViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDQuartz2DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"Quartz2D";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    self.tableView.tableFooterView = view;
    
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"1. 基础图形",
                    @"2. 其它图形",
                    @"3. 上下文",
                    @"4. ",
                    @"5. ",
                    @"6. 自定义画板", nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"quartzCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[KDShapeViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[KDQuartzOtherViewController new] animated:YES];
    } else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[KDContextViewController new] animated:YES];
    } else if (indexPath.row == 5) {
        [self.navigationController pushViewController:[KDPaintBoardViewController new] animated:YES];
    }
}

@end

