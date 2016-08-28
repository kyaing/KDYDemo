//
//  BaseViewModel.m
//  KDYDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDBaseViewModel.h"

@implementation KDBaseViewModel

- (NSMutableArray *)dataArrayList {
    if (_dataArrayList == nil) {
        _dataArrayList = [NSMutableArray array];
    }
    
    return _dataArrayList;
}

- (NSUInteger)numberOfSections {
    return 1;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    return 0;
}

- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return 0;
}

//内部调用
- (void)getDataList:(NSString *)url
             params:(NSDictionary *)params
            success:(void (^)(NSArray *data))success
            failure:(void (^)(NSError *error))failure {
    
}

//外部调用
- (void)getDataListSuccess:(void (^)())success
                   failure:(void (^)())failure {
    
}

@end

