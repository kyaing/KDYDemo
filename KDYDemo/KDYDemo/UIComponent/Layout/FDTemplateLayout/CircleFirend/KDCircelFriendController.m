//
//  KDCircelFriendController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/29.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDCircelFriendController.h"
#import "CircelFriendLayoutCell.h"
#import "CircleFriendModel.h"

#define CellIdentifer @"CircleCell"

@interface KDCircelFriendController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation KDCircelFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"朋友圈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[CircelFriendLayoutCell class] forCellReuseIdentifier:CellIdentifer];
    
    //设置让Cell分隔线铺满
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //模拟请求的数据
    [self requestDatas];
}

- (void)requestDatas {
    //加载CircleFirend.json的静态数据，并把字典转化为对应的Model
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataPathStr = [[NSBundle mainBundle] pathForResource:@"CircleFirend" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataPathStr];
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDics = myDic[@"feed"];
        
        NSMutableArray *entities = @[].mutableCopy;
        [feedDics enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[CircleFriendModel alloc] initWithDictionary:obj]];
        }];
        
        //现在数组就是装着Model的数组了
        self.dataSourceArr = entities;
        
        //请求完数据后，刷新表格
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = CellIdentifer;
    CircelFriendLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[CircelFriendLayoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.circleModel = self.dataSourceArr[indexPath.row];
    
    //评论内容出现，刷新Cell，定义block
    cell.block = ^() {
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate 
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //使用FDTemplateLayoutCell自动计算高度
    CGFloat height = [tableView fd_heightForCellWithIdentifier:CellIdentifer cacheByIndexPath:indexPath configuration:^(CircelFriendLayoutCell *cell) {
        cell.circleModel = self.dataSourceArr[indexPath.row];
    }];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

