//
//  KDFDLayoutViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDFDLayoutViewController.h"
#import "KDCircelFriendController.h"
#import "KDFDChatViewController.h"

@interface KDFDLayoutViewController ()
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation KDFDLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"动态计算Cell高度";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    self.tableView.tableFooterView = view;
    
    self.dataArr = [NSArray arrayWithObjects:@"1. 朋友圈",
                    @"2. 聊天界面",
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
        [self.navigationController pushViewController:[KDCircelFriendController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[KDFDChatViewController new] animated:YES];
    }
}

@end
