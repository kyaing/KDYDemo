//
//  KDHomeViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDHomeViewController.h"
#import "KDPostStatusViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "NSObject+YYModel.h"
#import "WBStatusLayout.h"
#import "WBModel.h"
#import "WBStatusCell.h"

@interface KDHomeViewController () <UITableViewDataSource, UITableViewDelegate, SinaWeiboRequestDelegate>
@property (nonatomic, strong) UITableView    *homeTableView;
@property (nonatomic, copy)   NSString       *topWeiboId;    ///用于请求新数据的最大微博ID
@property (nonatomic, copy)   NSString       *lastWeiboId;   ///用于上拉加载的最后的微博ID
@property (nonatomic, strong) NSMutableArray *layouts;       ///微博数据布局类
@property (nonatomic, strong) MBProgressHUD  *HUD;
@property (nonatomic, strong) UILabel        *showBarLabel;  ///显示新微博数目视图
@property (nonatomic, strong) UIButton       *sendStatusBtn; ///发微博按钮

@end

@implementation KDHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.userInteractionEnabled = NO;
    
    //添加表视图
    [self setupTableView];
    
    //验证微博是否验证
    if (self.sinaWeibo.isAuthValid) {
        //第一次加载数据
        [self loadWeiboData];
        
    } else {
        //登陆微博
        [self.sinaWeibo logIn];
    }
}

#pragma mark - Getter/Setter
- (UITableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
        _homeTableView.backgroundColor = kWBCellBackgroundColor;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.showsVerticalScrollIndicator = YES;
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
    }
    
    return _homeTableView;
}

- (NSMutableArray *)layouts {
    if (!_layouts) {
        _layouts = [NSMutableArray new];
    }
    
    return _layouts;
}

- (UIButton *)sendStatusBtn {
    if (!_sendStatusBtn) {
        _sendStatusBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 100, 45, 45)];
        _sendStatusBtn.backgroundColor = [UIColor orangeColor];
        _sendStatusBtn.layer.cornerRadius = 10;
        _sendStatusBtn.layer.masksToBounds = YES;
        _sendStatusBtn.alpha = 0.85;
        _sendStatusBtn.titleLabel.textColor = [UIColor whiteColor];
        _sendStatusBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
        [_sendStatusBtn setTitle:@"发微博" forState:UIControlStateNormal];
        [_sendStatusBtn addTarget:self action:@selector(sendStatusAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendStatusBtn;
}

#pragma mark - Request Datas
- (void)loadWeiboData {
    [self showHUD];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"10", @"count", nil];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"Get"
                          delegate:self];
}

///下拉刷新最新
- (void)getPullDownData {
    if (self.topWeiboId.length == 0) {
        NSLog(@"微博ID为空");
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"10", @"count", self.topWeiboId, @"since_id",  nil];
    
    __block KDHomeViewController *weakSelf = self;
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"Get"
                             block:^(id result) {
                                 //通过block得到数据
                                 [weakSelf getPullDownDataFinished:result];
                             }];
}

///上拉加载更多
- (void)getPullUpData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"10", @"count", self.lastWeiboId, @"max_id", nil];
    
    __weak KDHomeViewController *weakSelf = self;
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"Get"
                             block:^(id result) {
                                 //通过block得到数据
                                 [weakSelf getPullUpDataFinished:result];
                             }];
}

- (void)getPullDownDataFinished:(id)result {
    NSArray *statusArr = [result objectForKey:@"statuses"];
    NSMutableArray *newWeibos = [[NSMutableArray alloc] initWithCapacity:statusArr.count];
    
    for (NSDictionary *dic in statusArr) {
        WBStatus *status = [WBStatus objectWithKeyValues:dic];
        WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
        [layout setupLayout];
        
        [newWeibos addObject:layout];
    }
    
    //将原有的_layout数组添加到newWeibos后
    [newWeibos addObjectsFromArray:_layouts];
    _layouts = newWeibos;
    
    //显示下拉刷新的微博数目
    int updateCount = (int)statusArr.count;
    [self showNewWeiboCount:updateCount];
    
    //更新topWeiboId
    if (newWeibos.count > 0) {
        WBStatusLayout *statuLayout = [newWeibos objectAtIndex:0];
        _topWeiboId = [NSString stringWithFormat:@"%llu", statuLayout.status.statusID];
    }
    
    //刷新表视图
    [_homeTableView reloadData];
    [_homeTableView.header endRefreshing];
}

- (void)getPullUpDataFinished:(id)result {
    NSArray *statusArr = [result objectForKey:@"statuses"];
    NSMutableArray *moreWeibos = [[NSMutableArray alloc] initWithCapacity:statusArr.count];
    
    for (NSDictionary *dic in statusArr) {
        WBStatus *status = [WBStatus objectWithKeyValues:dic];
        WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
        [layout setupLayout];
        
        [moreWeibos addObject:layout];
    }
    
    [_layouts addObjectsFromArray:moreWeibos];
    
    //更新lastWeiboId(注意得到的ID要减1)
    if (moreWeibos.count > 0) {
        WBStatusLayout *statuLayout = [moreWeibos lastObject];
        _lastWeiboId = [NSString stringWithFormat:@"%llu", statuLayout.status.statusID - 1];
    }
    
    //刷新表视图(##这里需要优化：不能新的上拉加载的数据再次整体reloadData，这样太耗资源了！)
    [_homeTableView reloadData];
    [_homeTableView.footer endRefreshing];
}

#pragma mark - SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"error :%@", error);
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    [self hideHUD];
    
    NSArray *statusArr = [result objectForKey:@"statuses"];
    
    /**
     用GCD将微博数据在后台计算好布局，这样不用在主线程中实时计算高度。
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //将json转为model，再传入WBStatusLayout计算布局
        //##使用YYModel解析json -> 还是会有错！
        //        WBStatus *status;
        //        for (NSDictionary *dic in statusArr) {
        //            status = [WBStatus yy_modelWithDictionary:dic];
        //        }
        
        //##使用MJExtension -> 还是比较保险啊！
        for (NSDictionary *dic in statusArr) {
            WBStatus *status = [WBStatus objectWithKeyValues:dic];
            WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
            [layout setupLayout];
            
            [self.layouts addObject:layout];
        }
        
        //取得topWeiboId和lastWeiboId
        if (_layouts.count > 0) {
            WBStatusLayout *topLayout = [_layouts objectAtIndex:0];
            _topWeiboId = [NSString stringWithFormat:@"%llu", topLayout.status.statusID];
            
            WBStatusLayout *lastLayout = [_layouts lastObject];
            _lastWeiboId = [NSString stringWithFormat:@"%llu", lastLayout.status.statusID];
        }
        
        //再回到主线程上，刷新表视图
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationController.view.userInteractionEnabled = YES;
            [_homeTableView reloadData];
            
            //微博数据显示后 -> 显示发微博按钮
            [self.view addSubview:self.sendStatusBtn];
        });
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"homeCell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[WBStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //根据_layouts对应的布局，布局具体的cell
    [cell setStatusLayout:_layouts[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"indexPath row %ld; height = %f", indexPath.row, ((WBStatusLayout *)_layouts[indexPath.row]).totalHeight);
    return ((WBStatusLayout *)_layouts[indexPath.row]).totalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [UIView animateWithDuration:1.0 animations:^{
        _sendStatusBtn.alpha = 0.25;
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.75 animations:^{
        _sendStatusBtn.alpha = 0.85;
    }];
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

- (void)showHUD {
    //指示器
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.labelText = @"加载中...";
}

- (void)hideHUD {
    [_HUD hide:YES afterDelay:0.5];
}

- (void)setupTableView {
    [self.view addSubview:self.homeTableView];
    
    _homeTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新数据
        [self getPullDownData];
    }];
    
    _homeTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //上拉加载数据
        [self getPullUpData];
    }];
}

- (void)showNewWeiboCount:(NSInteger)count {
    if (_showBarLabel == nil) {
        _showBarLabel = [UILabel new];
        _showBarLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:192/255.0 blue:34/255.0 alpha:1];
        _showBarLabel.frame = CGRectMake(5, 30, kScreenWidth-10, 34);
        _showBarLabel.textAlignment = NSTextAlignmentCenter;
        _showBarLabel.layer.cornerRadius = 3.f;
        _showBarLabel.layer.masksToBounds = YES;
        _showBarLabel.textColor = [UIColor whiteColor];
        _showBarLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_showBarLabel];  //注意这里添加到self.view层上
    }
    
    if (count > 0) {
        _showBarLabel.text = [NSString stringWithFormat:@"%ld 条新微博", count];

        //动画显示_showBarLabel
        [UIView animateWithDuration:1.0 animations:^{
            //显示_showBarLabel
            _showBarLabel.frame = CGRectMake(5, 68, kScreenWidth-10, 34);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.5 animations:^{
                //隐藏_showBarLabel
                _showBarLabel.frame = CGRectMake(5, 30, kScreenWidth-10, 34);
            }];
        }];
    }
}

- (void)sendStatusAction {
    [self.navigationController pushViewController:[KDPostStatusViewController new] animated:YES];
}

@end
