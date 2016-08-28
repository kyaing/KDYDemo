//
//  BaseViewModel.h
//  KDYDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDBaseViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArrayList;

- (NSUInteger)numberOfSections;

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;

- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;

- (void)getDataList:(NSString *)url
             params:(NSDictionary *)params
            success:(void (^)(NSArray *))success
            failure:(void (^)(NSError *))failure;

- (void)getDataListSuccess:(void (^)())success
                   failure:(void (^)())failure;

@end

