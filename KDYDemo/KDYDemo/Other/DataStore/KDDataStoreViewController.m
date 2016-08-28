//
//  KDDataStoreViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/3/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDDataStoreViewController.h"
#import "KDFMDBViewController.h"
#import "KDArchiverViewController.h"

@interface KDDataStoreViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDDataStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"数据存储";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"1. FMDB",
                    @"2. 归档和反归档", nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
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
        [self.navigationController pushViewController:[KDFMDBViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[KDArchiverViewController new] animated:YES];
    } else if (indexPath.row == 2) {
    
    } else {
       
    }
}

@end

