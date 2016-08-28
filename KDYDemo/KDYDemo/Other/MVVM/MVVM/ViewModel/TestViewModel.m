//
//  TestViewModel.m
//  KDYDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "TestViewModel.h"

@implementation TestViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.model = [[TestModel alloc] init];
    }
    
    return self;
}

- (void)getDataListSuccess:(void (^)())success failure:(void (^)())failure {
    [self getDataList:nil params:nil success:^(NSArray *data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}

- (void)getDataList:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSArray *data))success failure:(void (^)(NSError *error))failure {
    //真正的网络请求发生在此！
    //...
}

- (TestModel *)getTestDatas {
    //return nil;
    
    TestModel *model = [TestModel new];
    model.name = @"kdy";
    model.date = @"2016-7-26";
    model.content = @"注意，此条是测试数据";
    
    return model;
}

@end

