//
//  KDMeViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDMeViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "WeiboMeCell.h"

@interface KDMeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *meTableView;
@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) NSArray *pictureArray;

@end

@implementation KDMeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
    [self getUserData];
    
    
}

#pragma mark - Getter/Setter
- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSArray alloc] initWithObjects:@"新的好友", @"微博等级", nil];
    }
    
    return _listArray;
}

- (NSArray *)pictureArray {
    if (!_pictureArray) {
        _pictureArray = [[NSArray alloc] initWithObjects:@"我的相册", @"我的点评", @"我的赞", nil];
    }
    
    return _pictureArray;
}

#pragma mark - Data Request 
- (void)getUserData {
    [self.sinaWeibo requestWithURL:@"users/show.json"
                            params:nil
                        httpMethod:@"Get"
                             block:^(id result) {
                                 //通过block得到数据
                                 [self getUserInfo:result];
                             }];
}

- (void)getUserInfo:(NSDictionary *)result {
    NSLog(@"%@", result);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.listArray.count;
    } else {
        return self.pictureArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indetifer = @"meCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifer];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        if (indexPath.section) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    switch (indexPath.section) {
        case 0:{
            WeiboMeCell *cell = [[WeiboMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meHeadCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
            break;
            
        case 1:{
            cell.textLabel.text = _listArray[indexPath.row];
            cell.imageView.image = nil;
        }
            break;
            
        case 2:{
            cell.textLabel.text = _pictureArray[indexPath.row];
            cell.imageView.image = nil;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//在TableView的style为Plain时，创建几个section后，为它们的section添加头视图高度，就会有间距了
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

//设置尾视图setion高度为FLT_MIN，就不会出现多余的表格了
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FLT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 44;
    }
}

#pragma mark - Private Methods
- (SinaWeibo *)sinaWeibo {
    AppDelegate *appDeleaget = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *weibo = appDeleaget.sinaweibo;
    
    return weibo;
}

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)setupTableView {
    _meTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _meTableView.dataSource = self;
    _meTableView.delegate = self;
    [self.view addSubview:_meTableView];
}

@end
