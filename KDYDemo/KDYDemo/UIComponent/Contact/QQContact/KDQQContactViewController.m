//
//  KDQQContactViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/9.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDQQContactViewController.h"
#import "QQHeaderView.h"
#import "FriendGroupModel.h"

@interface KDQQContactViewController () <UITableViewDataSource, UITableViewDelegate, QQHeaderViewDelegate>
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *firendsArr;

@end

@implementation KDQQContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"QQ联系人列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //加载数据
    [self loadDatas];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
}

- (void)loadDatas {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"friends.plist" withExtension:nil];
    NSArray *tempArr = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *fgArray = [NSMutableArray array];
    for (NSDictionary *dict in tempArr) {
        FriendGroupModel *friendGroup = [FriendGroupModel friendGroupWithDict:dict];
        [fgArray addObject:friendGroup];
    }
    
    self.firendsArr = fgArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.firendsArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FriendGroupModel *groupModel = self.firendsArr[section];
    
    //控制每组的展开和折叠(以isOpened的状态来返回行数)
    return (groupModel.isOpened == NO ? 0 : groupModel.friends.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idntifer = @"qqCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idntifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idntifer];
    }
    
    //设置cell的数据
    FriendGroupModel *group = self.firendsArr[indexPath.section];
    FriendModel *friend = group.friends[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:friend.icon];
    cell.imageView.backgroundColor = [UIColor redColor];
    cell.textLabel.text = friend.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = (friend.isVip ? [UIColor redColor] : [UIColor blackColor]);
    cell.detailTextLabel.text = friend.intro;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //使用自定义的headerView
    QQHeaderView *headerView = [QQHeaderView headViewWithTableView:tableView];
    headerView.groupModel = self.firendsArr[section];
    headerView.delegate = self;
    
    return headerView;
}

#pragma mark - QQHeaderViewDelegate 
- (void)clickHeaderView:(QQHeaderView *)headerView {
    [self.tableView reloadData];
}

@end

