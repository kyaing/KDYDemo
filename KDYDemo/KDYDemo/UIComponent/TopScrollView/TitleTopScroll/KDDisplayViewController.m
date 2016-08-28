//
//  KDDisplayViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/11.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDDisplayViewController.h"

#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height
#define KTitleFont [UIFont systemFontOfSize:15]   //默认标题字体

static CGFloat const KNavBarH = 64;               //导航条高度
static CGFloat const KTitleScrollViewH = 44;      //标题滚动视图的高度
static CGFloat const KTitleTransformScale = 1.3;  //标题缩放比例
static CGFloat const KUnderLineH = 2;             //下划线默认高度
static CGFloat const KMargin = 20;                //默认标题间距

@interface KDDisplayViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView   *titleScrollView;    //标题滚动视图
@property (nonatomic, strong) UIScrollView   *contentScrollView;  //内容滚动视图
@property (nonatomic, strong) NSMutableArray *titleLabelArr;      //标题标签数组
@property (nonatomic, strong) NSMutableArray *titleWidthArr;      //标题占有的宽度(标题)
@property (nonatomic, strong) UIView         *underLineView;      //下划线
@property (nonatomic, strong) UIView         *coverView;          //遮盖视图

@property (nonatomic, assign) CGFloat lastOffsetX;  //记录上一次内容滚动视图偏移量
@property (nonatomic, assign) BOOL isClickTitle;    //记录是否点击
@property (nonatomic, assign) BOOL isAniming;       //记录是否在动画
@property (nonatomic, assign) CGFloat titleMargin;  //标题间距

@end

@implementation KDDisplayViewController

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        _titleHeight = KTitleScrollViewH;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //设置标题滚动视图
    [self setupTitleScrollView];
    
    //设置内容滚动视图(#注意两个滚动视图都没有设置contentSize#)
    [self setupContentScrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //设置标题的宽度
    [self setupTitleWidth];
    
    //设置标题内容
    [self setupTitleLabel];
}

#pragma mark - Getter/Setter
- (UIColor *)normalColor {
    if (_isShowTitleGradient && _titleColorGradientStyle == YZTitleColorGradientStyleRGB) {
        _normalColor = [UIColor colorWithRed:_startR green:_startG blue:_startB alpha:1];
    }
    
    if (_normalColor == nil) {
        _normalColor = [UIColor blackColor];
    }
    
    return _normalColor;
}

- (UIColor *)selectColor {
    if (_isShowTitleGradient && _titleColorGradientStyle == YZTitleColorGradientStyleRGB) {
        _selectColor = [UIColor colorWithRed:_endR green:_endG blue:_endB alpha:1];
    }
    
    if (_selectColor == nil) {
        _selectColor = [UIColor redColor];
    }
    
    return _selectColor;
}

- (NSMutableArray *)titleLabelArr {
    if (_titleLabelArr == nil) {
        _titleLabelArr = [NSMutableArray array];
    }
    
    return _titleLabelArr;
}

- (NSMutableArray *)titleWidthArr {
    if (_titleWidthArr == nil) {
        _titleWidthArr = [NSMutableArray array];
    }
    
    return _titleWidthArr;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = _coverColor? _coverColor : [UIColor redColor];
        _coverView.layer.cornerRadius = _coverCornerRadius;
        _coverView.layer.masksToBounds = YES;
        [self.titleScrollView insertSubview:_coverView atIndex:0];
    }
    
    return _isShowTitleCover ? _coverView : nil;
}

- (UIView *)underLineView {
    if (_underLineView == nil) {
        _underLineView = [[UIView alloc] init];
        _underLineView.backgroundColor = _underLineColor ? _underLineColor : [UIColor redColor];
        [self.titleScrollView addSubview:_underLineView];
    }
    
    return _isShowUnderLine ? _underLineView : nil;
}

#pragma mark - UIScrollViewDelegate
//scrollView滚动(执行标题滚动一些细节动画)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isAniming) return;
    
    //得到水平的滚动偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / KScreenW;
    NSInteger rightIndex = leftIndex + 1;
    
    UILabel *leftLabel = self.titleLabelArr[leftIndex];
    UILabel *rightLabel = nil;
    if (rightIndex < self.titleLabelArr.count) {
        rightLabel = self.titleLabelArr[rightIndex];
    }
    
    //设置遮盖偏移 -> 腾讯视频
    [self setUpCoverWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    //设置缩放 -> 今日头条
    [self setupTitleSaceWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    //设置下标 -> 喜马拉雅
    [self setupUnderLineWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    //记录上次的偏移量
    _lastOffsetX = offsetX;
}

//监听滚动动画是否完成
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _isAniming = NO;  //滚动动画结束
}

//scrollView减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger extre = (NSInteger)offsetX % (NSInteger)KScreenW;
    if (extre > KScreenW * 0.5) {
        //往右边移动
        offsetX = offsetX + (KScreenW - extre);
        _isAniming = YES;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
    } else if (extre < KScreenW * 0.5 && extre > 0){
        _isAniming = YES;
        //往左边移动
        offsetX =  offsetX - extre;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    NSInteger index = offsetX / KScreenW;
    
    //选择标题
    [self selectTitleLabel:self.titleLabelArr[index]];
    
    //添加子控制器
    [self setupChildVC:index];
}

#pragma mark - Private Methods
//标题滚动视图
- (void)setupTitleScrollView {
    self.titleScrollView = [[UIScrollView alloc] init];
    self.titleScrollView.backgroundColor = _titleScrollViewColor ? _titleScrollViewColor : [UIColor colorWithWhite:1 alpha:0.7];
    CGFloat titleX = 0;
    CGFloat titleY = self.navigationController ? KNavBarH : 0;
    CGFloat titleW = KScreenW;
    CGFloat titleH = _titleHeight ? _titleHeight : KTitleScrollViewH;
    self.titleScrollView.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleScrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:self.titleScrollView];
}

//内容滚动视图
- (void)setupContentScrollView {
    self.contentScrollView  = [[UIScrollView alloc] init];
    CGFloat contentY = CGRectGetMaxY(self.titleScrollView.frame);
    self.contentScrollView .frame = _isfullScreen ? CGRectMake(0, 0, KScreenW, KScreenH) : CGRectMake(0, contentY, KScreenW, KScreenH - contentY);
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsHorizontalScrollIndicator = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
    [self.view insertSubview:self.contentScrollView belowSubview:self.titleScrollView];
}

//标题的宽度
- (void)setupTitleWidth {
    NSInteger count = self.childViewControllers.count;
    
    //利用KVO得到标题数组
    NSArray *titleArr = [self.childViewControllers valueForKey:@"title"];
    
    CGFloat totalWidth = 0;
    for (NSString *title in titleArr) {
        CGRect titleRect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KTitleFont} context:nil];
        CGFloat width = titleRect.size.width;
        totalWidth += width;
        
        [self.titleWidthArr addObject:@(width)];
    }
    
    if (totalWidth > KScreenW) {
        _titleMargin = KMargin;
        return;
    }
    
    //标题栏宽度小于KScreeW时，重新计算间距_titleMargin
    CGFloat titleMargin = (KScreenW - totalWidth) / (count + 1);
    _titleMargin = titleMargin < KMargin ? KMargin: titleMargin;
}

//标题内容
- (void)setupTitleLabel {
    //遍历子控制器，将控制器的标题赋值给titleScrollView
    NSInteger count = self.childViewControllers.count;
    
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        
        CGFloat labelX = 0;
        CGFloat labelY = 0;
        CGFloat labelW = 0;
        CGFloat labelH = 0;
        
        //展示文本->选择UILabel还是UIButton?
        UILabel *label = [[UILabel alloc] init];
        label.tag = i;
        label.text = vc.title;
        label.font = _titleFont ? _titleFont: KTitleFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.normalColor;
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitleLabelAction:)];
        [label addGestureRecognizer:tapGesture];
        
        //默认显示为第一个页(主动调用tap方法)
        if (i == 0) {
            [self tapTitleLabelAction:tapGesture];
        }
        
        //确定label的frame
        UILabel *perLabel = [self.titleLabelArr lastObject];
        labelX = _titleMargin + CGRectGetMaxX(perLabel.frame);
        labelW = [self.titleWidthArr[i] floatValue];
        labelH = self.titleHeight;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [self.titleLabelArr addObject:label];
        
        //向_titleScrollView父视图添加label
        [self.titleScrollView addSubview:label];
    }
    
    //在此设置滚动区域
    UILabel *lastLabel = [self.titleLabelArr lastObject];
    self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame) + 20, 0);
    self.contentScrollView.contentSize = CGSizeMake(KScreenW * count, 0);
}

- (void)tapTitleLabelAction:(UITapGestureRecognizer *)tapGesture {
    _isClickTitle = YES;
    
    UILabel *label = (UILabel *)tapGesture.view;
    NSInteger index = label.tag;  //取得点击的label下标
    
    //选中label
    [self selectTitleLabel:label];
    
    //点击label后设置内容的滚动偏移量
    CGFloat offsetX = KScreenW *index;
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    _lastOffsetX = offsetX;
    
    //添加子控制器
    [self setupChildVC:index];
    
    _isClickTitle = NO;
}

//选中标题
- (void)selectTitleLabel:(UILabel *)selectLabel {
    //选中标题之前，恢复之前的标题
    for (UILabel *temLabel in self.titleLabelArr) {
        if (temLabel == selectLabel) {
            continue;
        }
        
        temLabel.transform = CGAffineTransformIdentity;
        temLabel.textColor = self.normalColor;
    }
    
    //修改标题选中颜色
    selectLabel.textColor = self.selectColor;
    
    //设置选中标题居中
    [self setupTitleLabelCenter:selectLabel];
    
    //设置遮盖 -> 腾讯视频样式
    [self setupCoverView:selectLabel];
    
    //设置下标 -> 喜马拉雅样式
    [self setupUnderLine:selectLabel];
}

//选中标题居中显示
- (void)setupTitleLabelCenter:(UILabel *)label {
    //计算标题的偏移量，居中显示
    CGFloat offsetX = label.center.x - KScreenW * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - KScreenW;
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        //只需要偏移多出一屏距离，这样可以保证最右端不会滚动
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

//遮盖视图
- (void)setupCoverView:(UILabel *)label {
    //获取文字尺寸
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KTitleFont} context:nil];
    
    CGFloat border = 5;
    CGFloat coverH = titleBounds.size.height + 2 * border;
    CGFloat coverW = titleBounds.size.width + 2 * border;
    
    self.coverView.y = (label.height - coverH) * 0.5;
    self.coverView.height = coverH;
    
    //最开始不需要动画
    if (self.coverView.x == 0) {
        self.coverView.width = coverW;
        //self.coverView.x = label.x - border;
        
        self.coverView.x = label.centerX - 5;
        self.coverView.y = 8;
        
        return;
    }
    
    //点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.width = coverW;
        self.coverView.x = label.x - border;
    }];
}

//设置下标的位置
- (void)setupUnderLine:(UILabel *)label {
    //获取文字尺寸
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KTitleFont} context:nil];
    
    CGFloat underLineH = _underLineH ? _underLineH : KUnderLineH;
    
    self.underLineView.y = label.height - underLineH;
    self.underLineView.height = underLineH;
    
    //最开始不需要动画
    if (self.underLineView.x == 0) {
        self.underLineView.width = titleBounds.size.width;
        self.underLineView.x = label.x;
            NSLog(@"%lf, %lf", _underLineView.x, _underLineView.width);
        
        return;
    }
    
    //点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underLineView.width = titleBounds.size.width;
        self.underLineView.x = label.x;
    }];
}

//设置遮盖偏移
- (void)setUpCoverWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    if (_isClickTitle) return;
    
    //获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.x - leftLabel.x;
    
    //标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    
    //获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    
    //计算当前下划线偏移量
    CGFloat coverTransformX = offsetDelta * centerDelta / KScreenW;
    
    //宽度递增偏移量
    CGFloat coverWidth = offsetDelta * widthDelta / KScreenW;
    
    self.coverView.width += coverWidth;
    self.coverView.x += coverTransformX;
}

//获取两个标题按钮宽度差值
- (CGFloat)widthDeltaWithRightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    CGRect titleBoundsR = [rightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KTitleFont} context:nil];
    
    CGRect titleBoundsL = [leftLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KTitleFont} context:nil];
    
    return titleBoundsR.size.width - titleBoundsL.size.width;
}

//标题缩放
- (void)setupTitleSaceWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    if (_isShowTitleScale == NO) return;
    
    //获取右边缩放
    CGFloat rightSacle = offsetX / KScreenW - leftLabel.tag;
    CGFloat leftScale = 1 - rightSacle;
    
    CGFloat scaleTransform = _titleScale ? _titleScale : KTitleTransformScale;
    scaleTransform -= 1;
    
    //缩放按钮
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform +1, leftScale * scaleTransform +1);
    
    //1 ~ 1.2
    rightLabel.transform = CGAffineTransformMakeScale(rightSacle * scaleTransform +1, rightSacle * scaleTransform +1);
}

//标题下标
- (void)setupUnderLineWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    
}

- (void)setupChildVC:(NSInteger)index {
    UIViewController *childVC = self.childViewControllers[index];
    
    //判断childVC.view是否被添加到了某个view上
    if (childVC.view.superview) {
        return;
    }
    
    childVC.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:childVC.view];
}

@end

