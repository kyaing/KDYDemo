//
//  KDAllAnimationViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/4.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDAllAnimationViewController.h"
#import "KDBaseViewController.h"
#import "KDKeyframeViewController.h"
#import "KDGroupViewController.h"

@interface KDAllAnimationViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDAllAnimationViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"动画综合";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    self.tableView.tableFooterView = view;
    
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"1. 基础动画",
                        @"2. 关键帧动画",
                        @"3. 组动画",
                        @"4. 过渡动画",
                        @"5. 仿射动画",
                        @"6. 综合案例", nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"aniCell";
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
        [self.navigationController pushViewController:[KDBaseViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[KDKeyframeViewController new] animated:YES];
    } else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[KDGroupViewController new] animated:YES];
    }
}

@end

