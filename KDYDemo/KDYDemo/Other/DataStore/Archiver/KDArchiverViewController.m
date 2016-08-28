//
//  KDArchiverViewController.m
//  KDYDemo
//
//  Created by kaideyi on 16/3/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDArchiverViewController.h"
#import "MyPersonObject.h"

@interface KDArchiverViewController ()

@end

@implementation KDArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"归档";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupArchiver];
}

- (void)setupArchiver {
    MyPersonObject *person = [MyPersonObject new];
    
    person.name = @"SB";
    person.gender = @"女";
    person.age = 27;
    
    //将自定义的对象归档
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"friend.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:person toFile:path];
    if (success) {
        NSLog(@"归档成功！");
    }
    
    MyPersonObject *people = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"反归档：%@", people);
}

@end

