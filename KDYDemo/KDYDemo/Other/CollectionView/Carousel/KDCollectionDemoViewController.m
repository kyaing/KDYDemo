//
//  KDCollectionDemoViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/13.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDCollectionDemoViewController.h"
#import "KDMyCollectionViewController.h"
#import "CarouselViewLayout.h"

@interface KDCollectionDemoViewController () 
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KDCollectionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Carousel";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"Linear",
                    @"Horizontal",
                    @"Carousel",
                    @"CoverFlow", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CarouselViewLayout *layout = nil;
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            layout = [[CarouselViewLayout alloc] initWithAnimation:CarouselAnimationLinear];
            layout.visibleCount = 3;
            break;
            
        case 1:
            layout = [[CarouselViewLayout alloc] initWithAnimation:CarouselAnimationLinear];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            break;
            
        case 2:
            layout = [[CarouselViewLayout alloc] initWithAnimation:CarouselAnimationCarousel];
            break;
            
        case 3:
            layout = [[CarouselViewLayout alloc] initWithAnimation:CarouselAnimationCoverFlow];
            break;
            
        default:
            break;
    }
    
    layout.itemSize = CGSizeMake(250, 250);
    
    //直接初始化控制器为layout
    KDMyCollectionViewController *myVC = [[KDMyCollectionViewController alloc] initWithCollectionViewLayout:layout];
    [self.navigationController pushViewController:myVC animated:YES];
    
    //设置子控制器标题
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    myVC.title = cell.textLabel.text;
}

@end

