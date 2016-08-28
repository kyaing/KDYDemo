//
//  WBHomeTableView.m
//  KDYDemo
//
//  Created by zhongye on 16/2/19.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "WBHomeTableView.h"
#import "WBHomeTableViewCell.h"
#import "WBHomeCellViewModel.h"

static NSString *identifier = @"WBTableViewCell";

@interface WBHomeTableView () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation WBHomeTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[WBHomeTableViewCell class] forCellReuseIdentifier:identifier];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [self drawCell:cell withIndexPath:indexPath];

    return cell;
}

- (void)drawCell:(WBHomeTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    WBHomeCellViewModel *cellViewModel = [self.statusArray objectAtIndex:indexPath.row];
    cell.homeCellViewModel = cellViewModel;
    [cell drawCell];
}

#pragma mark - UITableViewDelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(WBHomeTableViewCell *cell) {
        [self drawCell:cell withIndexPath:indexPath];
    }];
    
    return height;
}

@end

