//
//  PhotoGroupView.m
//  KDYDemo
//
//  Created by zhongye on 16/2/25.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "PhotoGroupTableView.h"
#import "PhotoGroupCell.h"
#import "KDPhotoPickerController.h"

@interface PhotoGroupTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray  *groupsArray;

@end

@implementation PhotoGroupTableView

#pragma mark - Getter
- (ALAssetsLibrary *)assetsLibrary {
    if (_assetsLibrary == nil) {
        static dispatch_once_t oncen;
        static ALAssetsLibrary *library = nil;
        dispatch_once(&oncen, ^{
            library = [[ALAssetsLibrary alloc] init];
        });
        _assetsLibrary = library;
    }
    
    return _assetsLibrary;
}

- (NSMutableArray *)groupsArray {
    if (_groupsArray == nil) {
        _groupsArray = [[NSMutableArray alloc] init];
    }
    
    return _groupsArray;
}

#pragma mark - Public Methods
- (void)setupGroups {
    [self.groupsArray removeAllObjects];
    
    //获取相册中的分组资源
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlcok = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            //使用setAssetsFilter:(ALAssetsFilter *)filter进行过滤
            [group setAssetsFilter:self.assetsFilter];
            
            if (group.numberOfAssets > 0) {
                if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue]==ALAssetsGroupSavedPhotos) {
                    [self.groupsArray insertObject:group atIndex:0];
                    
                } else if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue]==ALAssetsGroupPhotoStream && self.groupsArray.count > 0) {
                    [self.groupsArray insertObject:group atIndex:1];
                    
                } else {
                    [self.groupsArray addObject:group];
                }
            }
        } else {
            //重新加载数据
            [self dataReload];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        //没权限
        
    };
    
    //显示的相册
    NSUInteger type = ALAssetsGroupSavedPhotos | ALAssetsGroupPhotoStream |
    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces  ;
    
    [self.assetsLibrary enumerateGroupsWithTypes:type
                                      usingBlock:resultBlcok
                                    failureBlock:failureBlock];
}

- (void)dataReload {
    if (self.groupsArray.count == 0) {
        
    }
    
    //弹出相册后，默认显示第一个group
    if (self.groupsArray.count > 0 && [self.groupDelegate respondsToSelector:@selector(didSelectedGroup:)]) {
        [self.groupDelegate didSelectedGroup:self.groupsArray[0]];
    }
}

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self registerClass:[PhotoGroupCell class] forCellReuseIdentifier:@"Cell"];
        self.dataSource = self;
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"Cell";
    PhotoGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[PhotoGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    //绑定数据
    [cell bind:[self.groupsArray objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self reloadData];
    ALAssetsGroup *group = [self.groupsArray objectAtIndex:indexPath.row];
    if (self.groupDelegate && [self.groupDelegate respondsToSelector:@selector(didSelectedGroup:)]) {
        [self.groupDelegate didSelectedGroup:group];
    }
}

@end

