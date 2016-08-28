//
//  KDLayoutViewController.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/24.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDLayoutViewController.h"
#import "KDAutolayoutViewController.h"
#import "KDSizeClassViewController.h"
#import "KDMasonryViewController.h"
#import "KDFDLayoutViewController.h"
#import "KDStackViewController.h"
#import "KDComressionViewController.h"
#import "KDScrollLayoutViewController.h"
#import "TestConvertViewController.h"

@interface KDLayoutViewController ()
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation KDLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"自动布局";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    self.tableView.tableFooterView = view;
    
    self.dataArr = [NSArray arrayWithObjects:@"1. Autolayout",
                    @"2. Size Class",
                    @"3. Masonry",
                    @"4. Masonry + FDTemplateLayout",
                    @"5. SnapKit + AutoCellHeight",
                    @"6. UIStackView + FDStackView",
                    @"7. CompressionResistance",
                    @"8. UIScrollView + Autolayout",
                    @"9. TestConvertViewController",
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
        [self.navigationController pushViewController:[KDAutolayoutViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[KDSizeClassViewController new] animated:YES];
    } else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[KDMasonryViewController new] animated:YES];
    } else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[KDFDLayoutViewController new] animated:YES];
    } else if (indexPath.row == 4) {
        
    } else if (indexPath.row == 5) {
        [self.navigationController pushViewController:[KDStackViewController new] animated:YES];
    } else if (indexPath.row == 6) {
        [self.navigationController pushViewController:[KDComressionViewController new] animated:YES];
    } else if (indexPath.row == 7) {
        [self.navigationController pushViewController:[KDScrollLayoutViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[TestConvertViewController new] animated:YES];
    }
}

@end

