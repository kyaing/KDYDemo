//
//  KDThreadViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/15.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDThreadViewController.h"

@interface KDThreadViewController ()

@end

@implementation KDThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"GCD测试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"查看XCode打印日志";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    /**
     Cocoa提供了丰富的和易于使用的异步API，如NSThread、GCD、NSOperationQueue等，
     那么如何选择呢？网上有人说，参考AFNetworking后选择多是NSOperation。
     但是我在用了AFNetworking之后，没有深入地了解过其中的机制，它是如何那么优秀的？
     
     NSThread封装性最差，最偏向于底层，主要基于thread使用。每一个NSThread对象代表着一个线程。
     GCD是基于C的API，直接使用比较方便，主要基于task使用。
     NSOperation是基于GCD封装的NSObject对象，对于复杂的多线程项目使用比较方便，主要基于队列使用。
     */
    
    //NSThread
    [self myNSThreadDemo];
    
    //GCD
    [self myGCDsDemo];
    
    //NSOperationQueue
    [self myNSOperationQueueDemo];
}

- (void)myNSThreadDemo {
    NSThread *myThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMain) object:nil];
    myThread.qualityOfService = NSQualityOfServiceDefault;
    [myThread start];
}

- (void)threadMain {
    //为线程设置名字，自定义的线程默认是没有runloop的
    [[NSThread currentThread] setName:@"myThread"];
    
    //如果没有数据源，runloop会在启动之后会立刻退出。所以需要给runloop添加一个数据源，这里添加的是NSPort数据源
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    while (![[NSThread currentThread] isCancelled]) {
        //启动runloop
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
}

- (void)myGCDsDemo {
    dispatch_queue_t myQueue = dispatch_queue_create("com.myQueue", NULL);
    dispatch_async(myQueue, ^{
        if ([NSThread isMainThread]) {
            NSLog(@"Main Thread");
        } else {
            NSLog(@"Not on Main Thread");
        }
    });
    
    printf("--------------------------\n");
    
    //调用前，查看当前线程
    NSLog(@"当前调用线程：%@", [NSThread currentThread]);
    
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.kaideyi.queue", NULL);
    
    //异步地添加一个任务到队列，将任务通过block包装起来
    dispatch_async(queue, ^{
        NSLog(@"开启了一个异步任务，当前线程：%@", [NSThread currentThread]);
    });
    
    //同步地添加一个任务到队列
    dispatch_sync(queue, ^{
       NSLog(@"开启了一个异步任务，当前线程：%@", [NSThread currentThread]);
    });
    
    printf("--------------------------\n");
    
    //并发地执行循环迭代
    //每次迭代执行的任务与其它迭代独立无关，而且循环迭代执行顺序也无关紧要的话，你可以调用dispatch_apply
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t count = 10;
    dispatch_apply(count, queue2, ^(size_t i) {
        printf("%zd ", i);
    });
    
    //异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@""];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [UIImageView new];
            imageView.image = image;
        });
    });
    
    printf("--------------------------\n");
    
    //同时下载两个图片，并在显示完成后在主线程中更新
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //创建一个组
        dispatch_group_t group = dispatch_group_create();
        
        //关联一个任务到group
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //下载第一张图片
            NSLog(@"dispatch - 1");
        });
        
        //关联一个任务到group
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //下载第二张图片
            NSLog(@"dispatch - 2");
        });
        
        //等待组中的任务执行完后，再回到主线程更新
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            //赋值两个图片
            NSLog(@"dispatch end");
        });
    });
    
    printf("--------------------------\n");
    
    //防止文件读写冲突，可以创建一个串行队列，操作都在这个队列中进行，没有更新数据读用并行，写用串行。
    dispatch_queue_t dataQueue = dispatch_queue_create("com.starming.gcddemo.dataqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"read data 1");
    });
    
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 2");
    });
    
    //等待前面的都完成，在执行barrier后面的
    dispatch_barrier_async(dataQueue, ^{
        NSLog(@"write data 1");
        [NSThread sleepForTimeInterval:1];
    });
    
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"read data 3");
    });
    
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 4");
    });
}

- (void)myNSOperationQueueDemo {
    
}

@end

