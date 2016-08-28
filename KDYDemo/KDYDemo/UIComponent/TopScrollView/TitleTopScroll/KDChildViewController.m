//
//  KDChildViewController.m
//  KDYDemo
//
//  Created by kaideyi on 15/12/12.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDChildViewController.h"

@interface KDChildViewController ()

@end

@implementation KDChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor =  [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    //如果有导航控制器，顶部需要添加额外滚动区域
    //添加额外滚动区域  导航条高度 + 标题高度
    //    if (self.navigationController) {
    //        CGFloat navBarH = self.navigationController.navigationBar.bounds.size.height;
    //        
    //        //查看自己标题滚动视图设置的高度，我这里设置为44
    //        CGFloat titleScrollViewH = 44;
    //        self.tableView.contentInset = UIEdgeInsetsMake(navBarH + titleScrollViewH, 0, 0, 0);
    //    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : 第%ld行数据", self.title, indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

