//
//  KDFrameHeightController.m
//  KDYDemo
//
//  Created by zhongye on 16/3/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDFrameHeightController.h"
#import "KDWebViewController.h"
#import "FrameHeightCellLayout.h"
#import "FrameHeightCell.h"
#import "CellHeightModel.h"
#import "KDFPSLabel.h"

@interface KDFrameHeightController () <FrameHeightCellDelegate>

//@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *layoutArray;  //存放布局好的数组
@property (nonatomic, strong) KDFPSLabel     *fpsLabel;

@end

@implementation KDFrameHeightController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Frame布局";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    
    //fps标签 => 用于测试帧率反映卡顿现象
    _fpsLabel = [KDFPSLabel new];
    _fpsLabel.backgroundColor = [UIColor lightGrayColor];
    _fpsLabel.bottom = self.view.height - 10;
    _fpsLabel.left = 10;
    _fpsLabel.alpha = 0;
    [_fpsLabel sizeToFit];
    [kAppWindow addSubview:_fpsLabel];
    
    //请求数据
    [self requestDatas];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_fpsLabel removeFromSuperview];
}

- (void)requestDatas {
    //等待指示器
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.size = CGSizeMake(80, 80);
    indicator.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.3);
    indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    indicator.clipsToBounds = YES;
    indicator.layer.cornerRadius = 6;
    [indicator startAnimating];
    [self.view addSubview:indicator];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"CellHeight" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataPath];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDics = [dic objectForKey:@"feed"];
        
        NSMutableArray *entities = @[].mutableCopy;
        [feedDics enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[CellHeightModel alloc] initWithDictionary:obj]];
        }];
        
        //现在数组就是装着布局好的数组了
        self.layoutArray = [NSMutableArray new];
        for (CellHeightModel *model in entities) {
            FrameHeightCellLayout *layout = [[FrameHeightCellLayout alloc] initWithModel:model];
            [_layoutArray addObject:layout];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [indicator removeFromSuperview];
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _layoutArray.count > 0 ? _layoutArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"Cell";
    FrameHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[FrameHeightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    //设置布局数据
    [cell setLayout:_layoutArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((FrameHeightCellLayout *)_layoutArray[indexPath.row]).height;
}

#pragma mark - UIScrollViewDelegate 
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - FrameHeightCellDelegate
- (void)cell:(FrameHeightCell *)cell didClickInLabel:(YYLabel *)label textRange:(NSRange)textRange {
    NSAttributedString *text = label.textLayout.text;
    if (textRange.location >= text.length) return;
    
    YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:textRange.location];
    NSDictionary *info = highlight.userInfo;
    if (info.count == 0) return;
    
    if (info[@"At"]) {   //@用户名
        NSString *name = info[@"At"];
        NSLog(@"name = %@", name);
        name = [name stringByURLEncode];
        
        if (name.length) {
            NSString *url = [NSString stringWithFormat:@"http://m.weibo.cn/n/%@", name];
            KDWebViewController *webVC = [[KDWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
    
    if (info[@"Web"]) {
        NSString *url = info[@"Web"];
        NSLog(@"url = %@", url);
        
        KDWebViewController *webVC = [[KDWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

@end

