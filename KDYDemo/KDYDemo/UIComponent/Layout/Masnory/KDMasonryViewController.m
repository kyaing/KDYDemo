//
//  KDMasnoryViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDMasonryViewController.h"
#import "MasonryComplexCell.h"

@interface KDMasonryViewController ()

@end

@implementation KDMasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"Masnory";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    MasonryComplexCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[MasonryComplexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //设置Cell的类型
    cell.cellType = indexPath.row % 3;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MasonryComplexCell getCellsHeight:indexPath.row % 3];
}

@end

