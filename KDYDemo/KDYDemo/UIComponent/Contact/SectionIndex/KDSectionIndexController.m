//
//  KDSectionIndexController.m
//  KDYDemo
//
//  Created by zhongye on 16/2/26.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDSectionIndexController.h"
#import "User.h"

#define NEW_USER(str) [[User alloc] init:str name:str]

@interface KDSectionIndexController () {
    NSMutableArray *userArray;      //数据源
    NSMutableArray *sectionsArray;  //分组数组
 
    //UITableView索引搜索工具类
    UILocalizedIndexedCollation *collation;
}

@end

@implementation KDSectionIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SectionIndex";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置索引颜色
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;

    //配置分组信息
    [self configureSections];
}

- (void)configureSections {
    //初始化测试数据
    userArray = [[NSMutableArray alloc] init];
    
    [userArray addObject:NEW_USER(@"test001")];
    [userArray addObject:NEW_USER(@"test002")];
    [userArray addObject:NEW_USER(@"test003")];
    
    [userArray addObject:NEW_USER(@"adam01")];
    [userArray addObject:NEW_USER(@"adam02")];
    [userArray addObject:NEW_USER(@"adam03")];
    
    [userArray addObject:NEW_USER(@"bobm01")];
    [userArray addObject:NEW_USER(@"bobm02")];
    
    [userArray addObject:NEW_USER(@"what01")];
    [userArray addObject:NEW_USER(@"0what02")];
    
    [userArray addObject:NEW_USER(@"李一")];
    [userArray addObject:NEW_USER(@"李二")];
    
    [userArray addObject:NEW_USER(@"胡一")];
    [userArray addObject:NEW_USER(@"胡二")];
    
    //获得当前UILocalizedIndexedCollation对象并且引用赋给collation，A-Z的数据
    collation = [UILocalizedIndexedCollation currentCollation];
    
    //获得索引数和section标题数
    NSInteger index, sectionTitlesCount = [[collation sectionTitles] count];
    
    //临时数据，存放section对应的userObjs数组数据
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //设置sections数组初始化：元素包含userObjs数据的空数据
    for (index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    //将用户数据进行分类，存储到对应的sesion数组中
    for (User *userObj in userArray) {
        //根据timezone的localename，获得对应的的section number
        NSInteger sectionNumber = [collation sectionForObject:userObj collationStringSelector:@selector(username2)];
        
        //获得section的数组
        NSMutableArray *sectionUserObjs = [newSectionsArray objectAtIndex:sectionNumber];
        
        //添加内容到section中
        [sectionUserObjs addObject:userObj];
    }
    
    //排序，对每个已经分类的数组中的数据进行排序，如果仅仅只是分类的话可以不用这步
    for (index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *userObjsArrayForSection = [newSectionsArray objectAtIndex:index];
        
        //获得排序结果
        NSArray *sortedUserObjsArrayForSection = [collation sortedArrayFromArray:userObjsArrayForSection collationStringSelector:@selector(username2)];
        
        //替换原来数组
        [newSectionsArray replaceObjectAtIndex:index withObject:sortedUserObjsArrayForSection];
    }
    
    sectionsArray = newSectionsArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[collation sectionTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *UserObjsInSection = [sectionsArray objectAtIndex:section];
    return [UserObjsInSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSArray *userNameInSection = [sectionsArray objectAtIndex:indexPath.section];
    
    User *userObj = [userNameInSection objectAtIndex:indexPath.row];
    cell.textLabel.text = userObj.username2;
    
    return cell;
}

//设置section的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *UserObjsInSection = [sectionsArray objectAtIndex:section];
    if (UserObjsInSection == nil || [UserObjsInSection count] <= 0) {
        return nil;
    }
    
    return [[collation sectionTitles] objectAtIndex:section];
}

//设置section标题的样式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.frame = CGRectMake(0, 0, tableView.frame.size.width, 20);
    sectionLabel.text = [NSString stringWithFormat:@"  %@", [[collation sectionTitles] objectAtIndex:section]];
    sectionLabel.textColor = RGB(51, 51, 51);
    sectionLabel.font = [UIFont systemFontOfSize:14];
    sectionLabel.backgroundColor = RGB(245, 245, 245);
    
    return sectionLabel;
}

//设置右边索引值
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [collation sectionIndexTitles];
}

//
- (NSArray *)existSectionIndex {
    NSArray *existIndex = [NSArray new];
    return existIndex;
}

//关联搜索
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title
               atIndex:(NSInteger)index {
    return [collation sectionForSectionIndexTitleAtIndex:index];
}

@end

