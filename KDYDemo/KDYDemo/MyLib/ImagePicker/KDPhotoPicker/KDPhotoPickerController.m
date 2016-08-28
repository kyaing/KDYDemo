//
//  KDPhotoPickerController.m
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDPhotoPickerController.h"
#import "PhotoGroupTableView.h"
#import "PhotoListCollectionView.h"

@interface KDPhotoPickerController () <PhotoGroupViewDelegate, PhotoListViewDelegate>

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIView      *navBarView;
@property (nonatomic, strong) UIImageView *selectTip;
@property (nonatomic, strong) UIButton    *okBtn;
@property (nonatomic, strong) UIView      *bgMaskView;

@property (nonatomic, strong) PhotoGroupTableView      *photoGroupView;
@property (nonatomic, strong) PhotoListCollectionView  *photoListView;

@end

@implementation KDPhotoPickerController

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _assetsFilter = [ALAssetsFilter allAssets];
        _selectionFilter = [NSPredicate predicateWithValue:YES];
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    //设置导航栏
    [self setupNavBarView];
    
    //加载相册分组
    [self setupPhotoGroupView];
    
    //加载列表资源
    [self setupPhotoListView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    //加载groups数据
    [self.photoGroupView setupGroups];
}

#pragma mark - Private
- (void)setupNavBarView {
    //导航栏
    UIView *navBarView = [UIView new];
    navBarView.backgroundColor = [UIColor redColor];
    [self.view addSubview:navBarView];
    self.navBarView = navBarView;
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [navBarView addSubview:cancelBtn];
    
    __weak typeof(self) weakSelf = self;
    [cancelBtn ky_addTargetAction:^(NSInteger tag) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [navBarView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tapBtn.backgroundColor = [UIColor clearColor];
    [navBarView addSubview:tapBtn];
    
    //点击按钮切换不同的group
    [tapBtn ky_addTargetAction:^(NSInteger tag) {
        self.photoGroupView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.photoGroupView.transform = CGAffineTransformMakeTranslation(0, 360);
            self.selectTip.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }];
    
    //选择的图片
    UIImageView *selectTip = [UIImageView new];
    selectTip.image = [UIImage imageNamed:@"BoSelectGroup_tip"];
    [navBarView addSubview:selectTip];
    self.selectTip = selectTip;
    
    //确定按钮
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [navBarView addSubview:okBtn];
    self.okBtn = okBtn;
    
    [okBtn ky_addTargetAction:^(NSInteger tag) {
        
    }];
    
    //以下是布局
    [navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@64);
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(navBarView);
        make.centerY.mas_equalTo(navBarView).offset(10);
    }];
    
    [tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titleLabel.mas_width).offset(50);
        make.centerX.mas_equalTo(navBarView);
        make.centerY.mas_equalTo(navBarView).offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [selectTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(titleLabel.mas_trailing).offset(10);
        make.width.mas_equalTo(@8);
        make.height.mas_equalTo(@5);
        make.centerY.mas_equalTo(titleLabel);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@44);
        make.leading.mas_equalTo(navBarView);
        make.top.mas_equalTo(navBarView).offset(20);
        make.width.mas_equalTo(@60);
    }];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@44);
        make.trailing.mas_equalTo(navBarView);
        make.top.mas_equalTo(navBarView).offset(20);
        make.width.mas_equalTo(@60);
    }];
}

- (void)setupPhotoGroupView {
    PhotoGroupTableView *groupView = [PhotoGroupTableView new];
    groupView.assetsFilter = self.assetsFilter;
    groupView.groupDelegate = self;
    [self.view insertSubview:groupView belowSubview:self.navBarView];
    
    groupView.hidden = YES;
    [groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navBarView.mas_bottom).offset(-360);
        make.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(@360);
    }];
    
    self.photoGroupView = groupView;
}

- (void)setupPhotoListView {
    PhotoListCollectionView *collectionView = [[PhotoListCollectionView alloc] init];
    collectionView.listDelegate = self;
    [self.view insertSubview:collectionView atIndex:0];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.bottom.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
    }];
    self.photoListView = collectionView;
}

- (void)hidenGroupView {
    [UIView animateWithDuration:0.3 animations:^{
        self.photoGroupView.transform = CGAffineTransformIdentity;
        self.selectTip.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        self.photoGroupView.hidden = YES;
    }];
}

#pragma mark - PhotoGroupViewDelegate
- (void)didSelectedGroup:(ALAssetsGroup *)assetsGroup {
    self.photoListView.assetsGroup = assetsGroup;
    
    //点击时改变顶部标题，同时隐藏groupView
    self.titleLabel.text = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    [self hidenGroupView];
}

#pragma mark - PhotoListViewDelegate
- (void)didSelectedAsset:(ALAsset *)asset {
    
}

@end

