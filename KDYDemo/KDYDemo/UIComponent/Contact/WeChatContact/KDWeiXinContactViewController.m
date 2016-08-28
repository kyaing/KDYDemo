//
//  KDWeiXinContactViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/8.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDWeiXinContactViewController.h"
#import "KDNoteViewController.h"

@interface KDWeiXinContactViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *footerView;        //联系人尾视图
@property (nonatomic, strong) UILabel *rightIndexLabel;   //联系人右侧索引列
@property (nonatomic, strong) UILabel *centerIndexLabel;  //界面上显示的索引
@property (nonatomic) CGFloat  indexLabelHeight;  //右侧索引实际的高度

@property (nonatomic, strong) NSMutableArray *dataArr;          //所有联系人数据
@property (nonatomic, strong) NSMutableArray *keysArr;          //联系人的分组keys
@property (nonatomic, strong) NSMutableArray *keyWithDataArr;   //key对应的联系人数组

@end

@implementation KDWeiXinContactViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"WeChat联系人列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    self.footerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    self.footerView.backgroundColor = [UIColor redColor];
    self.footerView.textColor = [UIColor lightGrayColor];
    self.footerView.textAlignment = NSTextAlignmentCenter;
    self.footerView.text = [NSString stringWithFormat:@"10位联系人"];
    self.footerView.font = [UIFont systemFontOfSize:15];
    self.tableView.tableFooterView = self.footerView;
    
    //本来是想设置分隔线填满整个cell，但是失败了！但是怎么做呢？
    //[self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    //创建索引
    [self setupIndexLabel];
}

- (void)setupIndexLabel {
    //右侧索引列
    self.rightIndexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.rightIndexLabel.backgroundColor = [UIColor clearColor];
    self.rightIndexLabel.textAlignment = NSTextAlignmentCenter;
    self.rightIndexLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
    self.rightIndexLabel.font = [UIFont systemFontOfSize:13];
    self.rightIndexLabel.numberOfLines = 0;
    self.rightIndexLabel.userInteractionEnabled = YES;  //开启交互
    for (int i = 0; i < self.keysArr.count; i++) {
        NSString *str = self.keysArr[i];
        //注意这里的"\n"表示换行
        self.rightIndexLabel.text = (i==0) ? str : [NSString stringWithFormat:@"%@\n%@", self.rightIndexLabel.text, str];
    }
    [self.view addSubview:self.rightIndexLabel];

    self.indexLabelHeight = [self getSizeWithContent:self.rightIndexLabel.text withFont:13.f].height;
    NSLog(@"==%f", self.indexLabelHeight);
    
    //根据实际的索引列高度计算索引的frame
    self.rightIndexLabel.frame = CGRectMake(self.view.bounds.size.width - 18, (self.view.bounds.size.height - self.indexLabelHeight)/2, 18, self.indexLabelHeight);
    
    //界面中间显示索引
    self.centerIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.centerIndexLabel.center = self.view.center;
    self.centerIndexLabel.textAlignment = NSTextAlignmentCenter;
    self.centerIndexLabel.layer.cornerRadius = 5.f;
    self.centerIndexLabel.layer.masksToBounds = YES;
    self.centerIndexLabel.font = [UIFont systemFontOfSize:30];
    self.centerIndexLabel.textColor = [UIColor whiteColor];
    self.centerIndexLabel.backgroundColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
    self.centerIndexLabel.alpha = 0;
    [self.view addSubview:self.centerIndexLabel];
}

- (CGSize)getSizeWithContent:(NSString *)content withFont:(CGFloat)fontNumber {
    NSDictionary *arrtibues = @{NSFontAttributeName: [UIFont systemFontOfSize:fontNumber]};
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(20, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesFontLeading attributes:arrtibues context:nil].size;
    
    return size;
}

#pragma mark - Touch Events
//触摸开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchIndex:touches];
}

//触摸移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchIndex:touches];
}

//触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.8 animations:^{
        _centerIndexLabel.alpha = 0;
    }];
}

- (void)touchIndex:(NSSet *)touches {
    [UIView animateWithDuration:0.5 animations:^{
        _centerIndexLabel.alpha = 1;
    }];

    //获得点击区域的点，并计算出对应的index
    UITouch *indexTouch = [touches anyObject];
    CGPoint point = [indexTouch locationInView:_rightIndexLabel];
    //此point为当前点击区域的点，超过这个区域的点都无法算出正确的index
    if (point.y < 0 || point.y > self.indexLabelHeight) {
        return;
    }
    int index = (point.y / (self.indexLabelHeight)) * (self.keysArr.count);
    NSLog(@"index: %d", index);
    _centerIndexLabel.text = _keysArr[index];
    
    //根据index跳到指定区域
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - Getter/Setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    return _dataArr;
}

- (NSMutableArray *)keysArr {
    if (_keysArr == nil) {
        _keysArr = [[NSMutableArray alloc] initWithObjects:@"B", @"D", @"E", @"F", @"G", @"H", @"L", @"Z", nil];
    }
    
    return _keysArr;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keysArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idntifer = @"contactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idntifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idntifer];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个cell", indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.keysArr[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //这里自定义右侧索引栏
    //NSArray *indexArr = [[NSArray alloc ]initWithObjects:@"A", @"B", nil];
    //return indexArr;
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //使用了editActionsForRowAtIndexPath后也就不用在此写相应的操作方法了
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除cell");
    } 
}

#pragma mark - UITableViewDelegate 
//重新设置section的头标题的显示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.textAlignment = NSTextAlignmentLeft;
    headerView.textLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1.0];
    headerView.textLabel.font = [UIFont systemFontOfSize:16];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //要实现左滑删除的那一行的编辑风格必须是delete的风格
    return UITableViewCellEditingStyleDelete;
}

//#warning iOS8之后才能用此API，此API要配合commitEditingStyle方法使用
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * action, NSIndexPath * indexPath) {
        NSLog(@"删除好友");
        
        //更新数据
        [_dataArr removeObjectAtIndex:indexPath.row];
        
        //更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    //添加一个备注按钮
    UITableViewRowAction *noteRowActoin = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"备注 " handler:^(UITableViewRowAction * action, NSIndexPath * indexPath) {
        NSLog(@"备注好友");
        
        [self.navigationController pushViewController:[KDNoteViewController new] animated:YES];
    }];
    noteRowActoin.backgroundColor = [UIColor blueColor];
    
    return @[deleteRowAction, noteRowActoin];
}

@end

