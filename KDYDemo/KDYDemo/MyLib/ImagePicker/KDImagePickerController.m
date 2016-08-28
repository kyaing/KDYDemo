//
//  KDImagePickerController.m
//  KDYDemo
//
//  Created by zhongye on 16/2/22.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDImagePickerController.h"
#import "KDPhotoPickerController.h"

@implementation KDImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片选择器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *selPhotoBtn = [UIButton new];
    [selPhotoBtn ky_setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [selPhotoBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [self.view addSubview:selPhotoBtn];
    
    __weak typeof(self) weakSelf = self;
    [selPhotoBtn ky_addTargetAction:^(NSInteger tag) {
        KDPhotoPickerController *pickerVC = [[KDPhotoPickerController alloc] init];
        pickerVC.assetsFilter = [ALAssetsFilter allPhotos];
        pickerVC.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            return YES;
        }];
        
        [weakSelf presentViewController:pickerVC animated:YES completion:nil];
    }];
    
    [selPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

@end

