//
//  KDViewController.m
//  KDYDemo
//
//  Created by kaideyi on 15/11/24.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDViewController.h"
#import "AniOneFromViewController.h"
#import "QQMsgViewController.h"
#import "KDCollectionViewController.h"
#import "KDChartViewController.h"
#import "KDLoadingViewController.h"
#import "KDWheelViewController.h"
#import "KDContactViewController.h"
#import "KDTopScrollViewController.h"
#import "KDNeedLogViewController.h"
#import "KDWeiboMainViewController.h"
#import "KDHomeViewController.h"
#import "KDImageTextViewController.h"
#import "KDAllAnimationViewController.h"
#import "KDQuartz2DViewController.h"
#import "KDWeChatViewController.h"
#import "KDImageBrowserViewController.h"
#import "KDLayoutViewController.h"
#import "KDNetwokController.h"
#import "KDAttributedViewController.h"
#import "KDImagePickerController.h"
#import "KDMyExtensionViewController.h"
#import "KDDataStoreViewController.h"
#import "KDChatToolBarController.h"
#import "KDMediaViewController.h"
#import "KDNewPlayerViewController.h"
#import "KDFrameHeightController.h"
#import "KDMVVMDemoController.h"
#import "SinaWeibo.h"

@interface KDViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *animationArr;  //动画的数据源
@property (nonatomic, strong) NSMutableArray *customUIArr;   //自定义的UI的数据源
@property (nonatomic, strong) NSMutableArray *othersArr;     //其它的数据源
@property (nonatomic, strong) NSMutableArray *thridPartArr;  //第三方库(可以多看优秀的第三方库，才能自己写出来)
@property (nonatomic, strong) NSMutableArray *subjectArr;    //模仿的APP
@property (nonatomic, copy) NSMutableArray *swiftArr;      //基础的swift语法等其它

@end

@implementation KDViewController

#pragma mark - Life Cycle
//+ (void)load {
//    NSLog(@"%s", __func__);
//}
//
//+ (void)initialize {
//    [super initialize];
//    NSLog(@"%s, %@", __func__, [self class]);
//}
//
//- (instancetype)init {
//    if (self = [super init]) {
//        NSLog(@"%s", __func__);
//    }
//    
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%s", __func__);
    
    self.title = @"KDYDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建tableView
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height-2)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [[NSUserDefaults standardUserDefaults] setObject:@{@"key": @"value"} forKey:@"dic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //NSLog(@"%s", __func__);
}

- (NSMutableArray *)animationArr {
    if (_animationArr == nil) {
        _animationArr = [[NSMutableArray alloc] initWithObjects:@"1. 转场动画",
                         @"2. 类似QQ未读消息拖拽的动画效果",
                         @"3. 模仿SCCatWaitingHUD加载动画的实现",
                         @"4. CAShapeLayer圆形图片加载动画",
                         @"5. ",
                         @"6. 动画综合",
                         nil];
    }
    
    return _animationArr;
}

- (NSMutableArray *)customUIArr {
    if (_customUIArr == nil) {
        _customUIArr = [[NSMutableArray alloc] initWithObjects:@"1. 轮播组件",
                        @"2. 自定义联系人界面",
                        @"3. 常见顶部标题滚动条",
                        @"4. 自动布局",
                        @"5. ",
                        @"6. Quartz2D",
                        nil];
    }
    
    return _customUIArr;
}

- (NSMutableArray *)othersArr {
    if (_othersArr == nil) {
        _othersArr = [[NSMutableArray alloc] initWithObjects:@"1. 集合视图",
                      @"2. 图文混排",
                      @"3. 绘制图表",
                      @"4. 数据存储",
                      @"5. RunTime和多线程",
                      @"6. 多媒体",
                      @"7. 再看图文混排",
                      @"8. MVVM+ReactiveCocoa",
                      nil];
    }
    
    return _othersArr;
}

- (NSMutableArray *)thridPartArr {
    if (_thridPartArr == nil) {
        _thridPartArr = [[NSMutableArray alloc] initWithObjects:@"1. 图片浏览库",
                      @"2. 图片缓存库",
                      @"3. 图文混排库",
                      @"4. 模型转换库",
                      @"5. 网络请求库",
                      @"6. 图片选择库",
                      @"7. 基础扩展库",
                      @"8. 聊天工具条",
                      @"9. 视频播放库", nil];
    }
    
    return _thridPartArr;
}

- (NSMutableArray *)subjectArr {
    if (_subjectArr == nil) {
        _subjectArr = [[NSMutableArray alloc] initWithObjects:@"1. 新浪微博",
                       @"2. 微信",
                       @"3. 苏宁易购",
                       @"4. 格瓦拉",
                       @"5. ",
                       @"6. ",
                       nil];
    }
    
    return _subjectArr;
}

- (NSMutableArray *)swiftArr {
    if (_swiftArr == nil) {
        _swiftArr = [[NSMutableArray alloc] initWithObjects:@"1. 基础语法", nil];
    }
    
    return _swiftArr;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.animationArr.count;
    } else if (section == 3) {
        return self.customUIArr.count;
    } else if (section == 4) {
        return self.othersArr.count;
    } else if (section == 5) {
        return self.thridPartArr.count;
    } else if (section == 0) {
        return self.subjectArr.count;
    } else if (section == 1) {
        return self.swiftArr.count;
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"kdyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    //设置数据
    if (indexPath.section == 2) {
        cell.textLabel.text = _animationArr[indexPath.row];
    } else if (indexPath.section == 3) {
        cell.textLabel.text = _customUIArr[indexPath.row];
    } else if (indexPath.section == 4) {
        cell.textLabel.text = _othersArr[indexPath.row];
    } else if (indexPath.section == 5) {
        cell.textLabel.text = _thridPartArr[indexPath.row];
    } else if (indexPath.section == 0) {
        cell.textLabel.text = _subjectArr[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = _swiftArr[indexPath.row];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return @"动画";
    } else if (section == 3) {
        return @"UI";
    } else if (section == 4) {
        return @"高级";
    } else if (section == 5) {
        return @"轮子";
    } else if (section == 0) {
        return @"APP";
    } else if (section == 1) {
        return @"Swift";
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 2) {  //动画
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[AniOneFromViewController new] animated:YES];
                break;
                
            case 1:
                [self.navigationController pushViewController:[QQMsgViewController new] animated:YES];
                break;
                
            case 2:
                
                break;
                
            case 3:
                [self.navigationController pushViewController:[KDLoadingViewController new] animated:YES];
                break;
                
            case 5:
                [self.navigationController pushViewController:[KDAllAnimationViewController new] animated:YES];
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 3) {  //UI
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[KDWheelViewController new] animated:YES];
                break;
                
            case 1:
                [self.navigationController pushViewController:[KDContactViewController new] animated:YES];
                break;
            
            case 2:
                [self.navigationController pushViewController:[KDTopScrollViewController new] animated:YES];
                break;
                
            case 3:
                [self.navigationController pushViewController:[KDLayoutViewController new] animated:YES];
                break;
                
            case 5:
                [self.navigationController pushViewController:[KDQuartz2DViewController new] animated:YES];
                break;
                
            default:
                break;
        }
        
    } else if (indexPath.section == 4) {  //高级
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[KDCollectionViewController new] animated:YES];
                break;
                
            case 1:
                [self.navigationController pushViewController:[KDImageTextViewController new] animated:YES];
                break;
                
            case 2:
                [self.navigationController pushViewController:[KDChartViewController new] animated:YES];
                break;
                
            case 3:
                [self.navigationController pushViewController:[KDDataStoreViewController new] animated:YES];
                break;
                
            case 4:
                [self.navigationController pushViewController:[KDNeedLogViewController new] animated:YES];
                break;
                
            case 5:
                [self.navigationController pushViewController:[KDMediaViewController new] animated:YES];
                break;
                
            case 6:
                [self.navigationController pushViewController:[KDFrameHeightController new] animated:YES];
                break;
                
            case 7:
                [self.navigationController pushViewController:[KDMVVMDemoController new] animated:YES];
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 5) {  //轮子
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[KDImageBrowserViewController new] animated:YES];
                break;
                
            case 1:
                break;
                
            case 2:
                [self.navigationController pushViewController:[KDAttributedViewController new] animated:YES];
                break;
                
            case 3:
                
                break;
                
            case 4:
                [self.navigationController pushViewController:[KDNetwokController new] animated:YES];
                break;
                
            case 5:
                [self.navigationController pushViewController:[KDImagePickerController new] animated:YES];
                break;
                
            case 6:
                [self.navigationController pushViewController:[KDMyExtensionViewController new] animated:YES];
                break;
                
            case 7:
                [self.navigationController pushViewController:[KDChatToolBarController new] animated:YES];
                break;
                
            case 8:
                [self.navigationController pushViewController:[KDNewPlayerViewController new] animated:YES];
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 0) {  //仿APP
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[KDWeiboMainViewController new] animated:YES];
                break;
                
            case 1:
                [self.navigationController pushViewController:[KDWeChatViewController new] animated:YES];
                break;
                
            case 2:
                
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {  //Swift
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[KDSwiftViewController new] animated:YES];
                break;
                
            case 1:
                break;
                
            case 2:
                
                break;
                
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.textColor = [UIColor blueColor];
    headerView.textLabel.font = [UIFont systemFontOfSize:17];
}

@end

