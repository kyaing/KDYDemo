//
//  KDBaseAnimationViewController.m
//  KDYDemo
//
//  Created by zhongye on 16/1/4.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "KDBaseViewController.h"

@interface KDBaseViewController ()
@property (nonatomic, strong) UIView *testView;  //测试视图
@property (nonatomic, strong) NSMutableArray *animationBtn;

@end

@implementation KDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"基础动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.testView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, kScreenHeight/2-100, 100, 100)];
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
    
    //CATextLayer
    [self setupCATextLayer];
    
    //CATransformLayer
    //[self setupCATransformLayer];
    
    //CAGradientLayer
    [self setupCAGradientLayer];
    
    //CAEmitterLayer
    //[self setupCAEmitterLayer];
    
    //创建动画按钮
    [self setupAnimationBtn];
}

#pragma mark - SubCALayer
- (void)setupCATextLayer {
    //CATextLayer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.backgroundColor = [UIColor yellowColor].CGColor;
    textLayer.frame = CGRectMake(10, 64, 200, 60);
    [self.view.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"I'm a CATextLayer. Lorem ipsum dolor sit amet, consectetur adipiscing";
    textLayer.string = text;
    
    textLayer.contentsScale = [UIScreen mainScreen].scale;
}

- (void)setupCATransformLayer {
    CATransform3D ct = CATransform3DIdentity;
    ct = CATransform3DTranslate(ct, 100, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_4, 1, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_4, 0, 1, 0);
    CALayer *cubeLayer = [self cubeWithTransform:ct];
    [self.view.layer addSublayer:cubeLayer];
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    //CATransformLayer
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //center the cube layer within the container
    CGSize containerSize = CGSizeMake(100, 100);
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    //apply the transform and return
    cube.transform = transform;
    
    return cube;
}

- (CALayer *)faceWithTransform:(CATransform3D)transform {
    CALayer *faceLayer = [CALayer layer];
    faceLayer.frame = CGRectMake(-50, -50, 100, 100);
    
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    faceLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    faceLayer.transform = transform;
    
    return faceLayer;
}

- (void)setupCAGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.backgroundColor = [UIColor greenColor].CGColor;
    gradientLayer.frame = CGRectMake(240, 70, 100, 100);
    [self.view.layer addSublayer:gradientLayer];
    
    //设置渐变颜色
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    
    //用locaton可以改变颜色的分布，否则颜色均匀渐变
    gradientLayer.locations = @[@0.0, @0.2, @0.5];
    
    //startPoint和endPoint是以坐标系进行定义的
    gradientLayer.startPoint = CGPointMake(0, 0);  //左上角
    gradientLayer.endPoint = CGPointMake(1, 1);  //右下角
}

- (void)setupCAEmitterLayer {
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = CGRectMake(100, 300, 200, 100);
    [self.view.layer addSublayer:emitter];

    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);

    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"Spark.png"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    emitter.emitterCells = @[cell];
}

#pragma mark - CAAnimation
- (void)setupAnimationBtn {
    self.animationBtn = [[NSMutableArray alloc] initWithObjects:@"位移", @"透明度", @"缩放", @"旋转", nil];
    
    for (int i = 0; i < _animationBtn.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.frame = CGRectMake(20 + 70*i, kScreenHeight-100, 60, 30);
        [btn setTitle:_animationBtn[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)clickBtnAction:(UIButton *)button {
    NSInteger index = button.tag;
    if (index == 0) {
        [self postionAnimation];
    } else if (index == 1) {
        [self opacityAnimation];
    } else if (index == 2) {
        [self scaleAnimation];
    } else  {
        [self rotationAnimation];
    }
}

///位移动画
- (void)postionAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, kScreenHeight/2-100)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth, kScreenHeight/2-100)];
    animation.duration = 1.f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.testView.layer addAnimation:animation forKey:@"positionAnimation"];
}

///透明度动画
- (void)opacityAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.f];
    animation.toValue = [NSNumber numberWithFloat:0.2f];
    animation.duration = 1.f;
    [self.testView.layer addAnimation:animation forKey:@"opacityAnimation"];
}

///缩放动画
- (void)scaleAnimation {
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    //    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    //    animation.duration = 1.f;
    //    [self.testView.layer addAnimation:animation forKey:@"boundsAnimation"];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = [NSNumber numberWithFloat:2.f];
    animation.duration = 1.f;
    [self.testView.layer addAnimation:animation forKey:@"scaleAnimation"];
}

///缩放动画
- (void)rotationAnimation {
    //以X轴旋转
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    //    animation.toValue = [NSNumber numberWithFloat:M_PI];
    //    animation.duration = 1.f;
    //    [self.testView.layer addAnimation:animation forKey:@"rotationAnimaton"];
    
    //以Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.duration = 1.f;
    [self.testView.layer addAnimation:animation forKey:@"rotationAnimaton"];
}

@end

