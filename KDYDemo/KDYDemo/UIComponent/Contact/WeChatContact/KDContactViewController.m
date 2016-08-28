//
//  KDContactViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/9.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDContactViewController.h"
#import "KDQQContactViewController.h"
#import "KDWeiXinContactViewController.h"
#import "KDSectionIndexController.h"

@interface KDContactViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation KDContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联系人列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
    
    self.dataArr = [[NSArray alloc] initWithObjects:@"1. QQ联系人列表",
                    @"2. WeChat联系人列表",
                    @"3. UILocailzedIndexedCollation",
                    nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[KDQQContactViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[KDWeiXinContactViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[KDSectionIndexController new] animated:YES];
    }
}

@end
