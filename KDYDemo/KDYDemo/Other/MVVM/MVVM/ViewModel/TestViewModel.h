//
//  TestViewModel.h
//  KDYDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDBaseViewModel.h"
#import "TestModel.h"

@interface TestViewModel : KDBaseViewModel

@property (nonatomic, strong) TestModel *model;

//得到数据模型(TestModel)
- (TestModel *)getTestDatas;

@end

