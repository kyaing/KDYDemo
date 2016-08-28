//
//  KDNewPlayerViewController.m
//  KDYDemo
//
//  Created by kaideyi on 16/3/10.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDNewPlayerViewController.h"

@interface KDNewPlayerViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDNewPlayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"MultiMedia";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [UIView new];
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"1. ",
                    @"", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"Cell";
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

    } else if (indexPath.row == 1) {

    } else if (indexPath.row == 2) {

    } else {
        
    }
}

@end

