//
//  KDImageTextViewController.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDImageTextViewController.h"
#import "KDCoreTextViewController.h"
#import "KDTextKitViewController.h"

@interface KDImageTextViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *coreTextArr;
@property (nonatomic, strong) NSMutableArray *textKitArr;

@end

@implementation KDImageTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图文混排";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    self.tableView.tableFooterView = view;
    
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"@1 CoreText", @"@2 TextKit", nil];
}

- (NSMutableArray *)coreTextArr {
    if (_coreTextArr == nil) {
        _coreTextArr = [[NSMutableArray alloc] initWithObjects:@"CoreTextView",
                        @"CoreImageTextView",
                        @"CoreTextEmojiView",
                        nil];
    }
    
    return _coreTextArr;
}

- (NSMutableArray *)textKitArr {
    if (_textKitArr == nil) {
        _textKitArr = [[NSMutableArray alloc] initWithObjects:@"TextKitView",
                        nil];
    }
    
    return _textKitArr;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.coreTextArr.count;
    } else if (section == 1) {
        return self.textKitArr.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"textCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    //设置数据
    if (indexPath.section == 1) {
        cell.textLabel.text = _textKitArr[indexPath.row];
    } else if (indexPath.section == 0) {
        cell.textLabel.text = _coreTextArr[indexPath.row];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_dataArr objectAtIndex:section];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[[KDCoreTextViewController alloc] initWithTextClassName:_coreTextArr[indexPath.row]] animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.textColor = [UIColor blueColor];
    headerView.textLabel.font = [UIFont systemFontOfSize:17];
}

@end

