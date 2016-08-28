//
//  KDContextViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/11.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDContextViewController.h"
#import "QuartzCTMView.h"

@interface KDContextViewController ()
@property (nonatomic, strong) NSMutableArray  *shapeBtn;

@end

@implementation KDContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"上下文";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupBitmap];
    [self setupContextBtn];
}

- (void)setupContextBtn {
    self.shapeBtn = [[NSMutableArray alloc] initWithObjects:@"位图", @"PDF", @"CTM", nil];
    
    for (int i = 0; i < _shapeBtn.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.frame = CGRectMake(20 + 70*i, kScreenHeight-100, 60, 30);
        [btn setTitle:_shapeBtn[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)clickBtnAction:(UIButton *)button {
    NSInteger index = button.tag;
    
    if (index == 0) {
        [self setupBitmap];
    } else if (index == 1) {
        [self setupPDF];
    } else {
        [self setupCTM];
    }
}

- (void)removeSubView:(id)object {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[object class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)setupBitmap {
    [self removeSubView:[QuartzCTMView class]];
    
    UIImage *image = [self drawImageAtImageContext];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

- (void)setupPDF {
    [self drawPdfAtPDFContext];
}

- (void)setupCTM {
    [self removeSubView:[UIImageView class]];
    
    QuartzCTMView *ctmView = [QuartzCTMView new];
    ctmView.backgroundColor = [UIColor clearColor];
    ctmView.frame = CGRectMake(0, 100, kScreenWidth, 350);
    [self.view addSubview:ctmView];
}

- (UIImage *)drawImageAtImageContext {
    //获得一个位图图形上下文
    CGSize size = CGSizeMake(300, 200);  //画布大小
    UIGraphicsBeginImageContext(size);
    
    UIImage *image = [UIImage imageNamed:@"startpage"];
    [image drawInRect:CGRectMake(0, 0, 300, 200)];  //这里的位置相对于画布非屏幕而言
    
    //添加水印
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 200, 178);
    CGContextAddLineToPoint(context, 280, 178);
    
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(context, 2);
    CGContextDrawPath(context, kCGPathStroke);
    
    NSString *str = @"I Love U";
    [str drawInRect:CGRectMake(200, 158, 120, 30) withAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Marker Felt" size:15], NSForegroundColorAttributeName: [UIColor greenColor]}];
    
    //返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭位图上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

//利用PDF上下文绘制出PDF文档
- (void)drawPdfAtPDFContext {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths firstObject] stringByAppendingString:@"/myPDF.pdf"];
    NSLog(@"path = %@", path);
    
    /**
     启用PDF图形上下文
     path: 保存路径
     bounds: pdf文档大小，如果设置为CGRectZero则使用默认值：612*792
     pageInfo: 页面设置,为nil则不设置任何信息
     */
    UIGraphicsBeginPDFContextToFile(path, CGRectZero, [NSDictionary dictionaryWithObjectsAndKeys:@"Kenshin Cui",kCGPDFContextAuthor, nil]);
    
    //由于pdf文档是分页的，所以首先要创建一页画布供我们绘制
    UIGraphicsBeginPDFPage();
    
    NSString *title = @"Welcome to Apple Support";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    NSTextAlignment align = NSTextAlignmentCenter;
    style.alignment = align;
    
    [title drawInRect:CGRectMake(26, 20, 300, 50) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSParagraphStyleAttributeName:style}];
    NSString *content = @"Learn about Apple products, view online manuals, get the latest downloads, and more. Connect with other Apple users, or get service, support, and professional advice from Apple.";
    NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc] init];
    style2.alignment = NSTextAlignmentLeft;

    [content drawInRect:CGRectMake(26, 56, 300, 255) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:style2}];
    
    UIImage *image = [UIImage imageNamed:@"applecare_folks_tall.png"];
    [image drawInRect:CGRectMake(316, 20, 290, 305)];
    
    UIImage *image2 = [UIImage imageNamed:@"applecare_page1.png"];
    [image2 drawInRect:CGRectMake(6, 320, 600, 281)];
    
    //创建新的一页继续绘制其他内容
    UIGraphicsBeginPDFPage();
    UIImage *image3 = [UIImage imageNamed:@"applecare_page2.png"];
    [image3 drawInRect:CGRectMake(6, 20, 600, 629)];
    
    //关闭PDF上下文
    UIGraphicsEndPDFContext();
}

@end

