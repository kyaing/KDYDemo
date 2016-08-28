//
//  KDFMDBViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/3/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDFMDBViewController.h"
#import "FMDatabaseQueue.h"

@interface KDFMDBViewController ()

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;
@property (nonatomic, copy)   NSString   *tableName;

@end

@implementation KDFMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"使用FMDB";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //FMDatabaseQueue
    [self setupFMDatabaseQueue];
}

- (FMDatabase *)db {
    if (_db == nil) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [path stringByAppendingPathComponent:@"tmp.db"];
        NSLog(@"dbPath = %@", dbPath);
        _db = [FMDatabase databaseWithPath:dbPath];
    }
    
    return _db;
}

- (BOOL)createTable {
    [self.db open];
    
    self.tableName = @"friend_table";
    BOOL isExist = [self.db tableExists:_tableName];
    BOOL isSucess = NO;
    
    //无表则建表
    if (!isExist) {
        NSString *sql = [NSString stringWithFormat:@"create table '%@' (friendId text PRIMARY KEY, name text, age text, address text)", _tableName];
        isSucess = [self.db executeUpdate:sql];
    } else {
        isSucess = YES;
    }
    
    return isSucess;
}

- (void)updateTable {
    if ([self createTable]) {
        //有表则更新数据
        NSString *updateSql = [NSString stringWithFormat:@"replace into '%@' (friendId, name, age, address) values ('%@', '%@', '%@', '%@')", _tableName, @"frined_1", @"kai", @"25", @"河南郑州"];
        
        BOOL isOk = [self.db executeUpdate:updateSql];
        if (!isOk) {
            NSLog(@"更新错误！");
        }
    }
}

- (void)selectTable {
}

#pragma mark - 使用FMDatabaseQueue
- (void)setupFMDatabaseQueue {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/test.db"];
    NSLog(@"path = %@", path);
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [_db executeUpdate:@"create table if not exists testTable (id integer PRIMARY KEY AUTOINCREMENT, name text)"];
        NSLog(@"create %@", result ? @"success" : @"fail");
    }];
    
    NSDate *oneDate = [NSDate date];
    [_queue inDatabase:^(FMDatabase *db) {
        for (int i = 0; i < 50; i++) {
            [_db executeUpdate:@"insert into testTable (name) values (?)", [NSString stringWithFormat:@"name-%d", i]];
        }
    }];
    NSDate *twoDate = [NSDate date];
    NSTimeInterval first = [twoDate timeIntervalSinceDate:oneDate];
    
    NSDate *threeDate = [NSDate date];
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result = YES;
        for (int i = 0; i < 500; i++) {
            result = [_db executeUpdate:@"insert into testTable (name) values (?)", [NSString stringWithFormat:@"name-%d", i]];
            
            if (!result) {
                NSLog(@"break---");
                *rollback = YES;
                break;
            }
        }
    }];
    NSDate *fourDate = [NSDate date];
    NSTimeInterval second = [fourDate timeIntervalSinceDate:threeDate];
    NSLog(@"first = %lf; second = %lf", first, second);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            BOOL reslut = YES;
            for (int i = 50; i < 100; i++) {
                reslut = [_db executeUpdate:@"insert into testTable (name) values (?)", [NSString stringWithFormat:@"name-%d", i]];
                
                if (!reslut) {
                    NSLog(@"break---");
                    *rollback = YES;
                    break;
                }
            }
        }];
    });
}

@end

