//
//  TestViewManager.h
//  KDYDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestView.h"
#import "TestModel.h"

@interface TestViewManager : NSObject

@property (nonatomic, strong) TestView  *testView;
@property (nonatomic, strong) TestModel *testModel;

@end

