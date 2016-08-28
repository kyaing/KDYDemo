//
//  KDCollectionViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/11/30.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDCollectionViewController.h"
#import "KDBaseCollectionViewController.h"
#import "KDFlowCollectionViewController.h"
#import "KDCollectionDemoViewController.h"
#import "KDCollectionAnimaController.h"

@interface KDCollectionViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"集合视图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [UIView new];
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"1. 基础用法",
                    @"2. 自定义瀑布流",
                    @"3. Carousel",
                    @"4. Pinterest",
                    @"5. Timeline",
                    @"6. Collection动画", nil];
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
        [self.navigationController pushViewController:[KDBaseCollectionViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[KDFlowCollectionViewController new] animated:YES];
    } else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[KDCollectionDemoViewController new] animated:YES];
    } else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[KDPinterestViewController new] animated:YES];
    } else if (indexPath.row == 4) {
        //[self.navigationController pushViewController:[KDTimelineViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[KDCollectionAnimaController new] animated:YES];
    }
}

@end

