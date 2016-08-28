//
//  KDFDChatViewController.m
//  KDYDemo
//
//  Created by kaideyi on 16/1/31.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDFDChatViewController.h"
#import "BaseChatTableCell.h"
#import "TimeChatTableCell.h"
#import "TextChatTableCell.h"
#import "ImageChatTableCell.h"
#import "ChatKeyboardBar.h"
#import "ChatModel.h"

@interface KDFDChatViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSourceArr;
@property (nonatomic, strong) ChatKeyboardBar   *chatKeyboard;

@end

@implementation KDFDChatViewController

#pragma mark - Getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-49);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //发送方Cell类型
        [_tableView registerClass:[TextChatTableCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@"1", @"1")];
        [_tableView registerClass:[ImageChatTableCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@"1", @"2")];
        
        //接收方Cell类型
        [_tableView registerClass:[TextChatTableCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@"0", @"1")];
        [_tableView registerClass:[ImageChatTableCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@"0", @"2")];
        
        //时间Cell类型
        [_tableView registerClass:[TimeChatTableCell class] forCellReuseIdentifier:kTimeCellReusedID];
    }
    
    return _tableView;
}

- (ChatKeyboardBar *)chatKeyboard {
    if (_chatKeyboard == nil) {
        _chatKeyboard = [[ChatKeyboardBar alloc] init];
        _chatKeyboard.frame = CGRectMake(0, kScreenHeight-49, kScreenWidth, 49);
    }
    
    return _chatKeyboard;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聊天界面";
    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatKeyboard];
    
    [self requestDatas];
}

- (void)requestDatas {
    //加载CircleFirend.json的静态数据，并把字典转化为对应的Model
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataPathStr = [[NSBundle mainBundle] pathForResource:@"Chat" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataPathStr];
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDics = myDic[@"feed"];
        
        NSMutableArray *entities = @[].mutableCopy;
        [feedDics enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[ChatModel alloc] initWithDictionary:obj]];
        }];
        
        //现在数组就是装着Model的数组了
        self.dataSourceArr = entities;
        
        //请求完数据后，刷新表格
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatModel *model = self.dataSourceArr[indexPath.row];
    BaseChatTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID(model)];
    if (cell == nil) {
        cell = [[BaseChatTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseID(model)];
    }
    cell.model = self.dataSourceArr[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatModel *model = self.dataSourceArr[indexPath.row];
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kCellReuseID(model) cacheByIndexPath:indexPath configuration:^(BaseChatTableCell *cell) {
        cell.model = model;
    }];
    
    return height;
}

@end

