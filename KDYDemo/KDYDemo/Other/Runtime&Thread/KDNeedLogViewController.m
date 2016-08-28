//
//  KDNeedLogViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDNeedLogViewController.h"
#import "KDRuntimeViewController.h"
#import "KDThreadViewController.h"
#import "KDDownLoadViewController.h"

@interface KDNeedLogViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDNeedLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Thread";
    self.tableView.tableFooterView = [UIView new];
    
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"1. Runtime",
                    @"2. GCD/NSThread/NSOperation",
                    @"3. NSURLSession",
                    @"4. GCDDemo",
                    nil];
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
        [self.navigationController pushViewController:[KDRuntimeViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[KDThreadViewController new] animated:YES];
    } else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[KDDownLoadViewController new] animated:YES];
    } else if (indexPath.row == 3) {
        
    }
}

@end
