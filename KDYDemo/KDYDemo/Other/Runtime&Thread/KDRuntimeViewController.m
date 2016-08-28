//
//  KDRuntimeViewController.m
//  KDYDemo
//
//  Created by zhongye on 15/12/16.
//  Copyright © 2015年 kaideyi.com. All rights reserved.
//

#import "KDRuntimeViewController.h"
#import <objc/runtime.h>
#import "Masonry.h"

#pragma mark - Person
@interface Person : NSObject {
    @private float _height;
}

/**
 @property会做三个工作：
    - 生成一个带下划线的成员变量。
    - 生成成员变量的get方法。
    - 生成成员变量的set方法。
 */
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) int       age;

@end

@implementation Person

+ (void)load {
    Method methodOne = class_getInstanceMethod(self, @selector(methodOne:));
    Method methodTwo = class_getInstanceMethod(self, @selector(methodTwo:));
    
    //交换两个方法的实现(交换方法的参数必须是匹配的，参数的类型是一致的)
    method_exchangeImplementations(methodOne, methodTwo);
}

/**
 任何一个方法都有两个重要的属性：SEL是方法的编号，IMP是方法的实现，
 方法的调用实际上去根据SEL寻找IMP。
 */
- (NSString *)methodOne:(NSString *)str {
    NSLog(@"%@", [self methodTwo:str]);
    return @"suc";
}

- (NSString *)methodTwo:(NSString *)str {
    NSLog(@"%@", [self methodOne:str]);
    return @"suc";
}

- (void)method1 {
    NSLog(@"call method method1");
}

- (void)method2 {
    NSLog(@"call method method2");
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(self.class, &count);
        for (int i = 0; i < count; i++) {
            const char *cname = ivar_getName(ivars[i]);
            NSString *name= [NSString stringWithUTF8String:cname];
            NSString *key = [name substringFromIndex:1];
            
            id value = [aDecoder decodeObjectForKey:key];  //解码
            [self setValue:value forKey:key];  //设置key对应的value
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    for (int i = 0; i < count; i++) {
        const char *cname = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:cname];
        NSString *key = [name substringFromIndex:1];
        
        id value = [self valueForKey:key]; // 取出key对应的value
        [aCoder encodeObject:value forKey:key]; // 编码
    }
}

@end

#pragma mark - KDRuntimeViewController
@interface KDRuntimeViewController () {
    Person *person;
}

@end

@implementation KDRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Runtime小测试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    person = [[Person alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点击屏幕，再看XCode打印";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    unsigned int count = 0;
    //    Class *classes = objc_copyClassList(&count);
    //    for (int i = 0; i < count; i++) {
    //        const char *cname = class_getName(classes[i]);
    //        printf("%s\n", cname);
    //    }
    
    Class classPerson = NSClassFromString(@"Person");
    
#pragma mark - 类&对象
    NSLog(@"class name = %s", class_getName(classPerson));
    NSLog(@"super class name = %s", class_getName(class_getSuperclass(classPerson)));
    
    //    Class cls = objc_allocateClassPair(person.class, "MySubClass", 0);
    //    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    //    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
    
    NSLog(@"--------------分隔线--------------");

#pragma mark - 成员变量&属性
    float a[] = {1.0, 2.0, 3.0};
    NSLog(@"array encoding type: %s", @encode(typeof(a)));
    
    static char myKey;
    objc_setAssociatedObject(self, &myKey, classPerson, OBJC_ASSOCIATION_RETAIN);  //设置关联对象
    id anyObject = objc_getAssociatedObject(self, &myKey);   //得到关联的对象
    NSLog(@"anyObject = %@", NSStringFromClass(anyObject));
    objc_removeAssociatedObjects(anyObject);
    
    unsigned int count = 0;
    //获得成员变量列表
    Ivar *ivarList = class_copyIvarList(classPerson, &count);
    for (int i = 0; i < count; i++) {
        const char *cname = ivar_getName(ivarList[i]);
        NSString *name = [NSString stringWithUTF8String:cname];
        NSLog(@"ivar = %@", name); //=> _height, _age, _name, 为什么会出现三个成员变量呢？原因在@property
    }
    
    //获得属性列表
    objc_property_t *propertyList = class_copyPropertyList(classPerson, &count);
    for (int i = 0; i < count; i++) {
        const char *cname = property_getName(propertyList[i]);
        NSString *name = [NSString stringWithUTF8String:cname];
        NSLog(@"property = %@", name);    //=> name, age
    }
    
    NSLog(@"--------------分隔线--------------");
    
#pragma mark - 方法&消息
    //SEL表示方法选择器
    SEL sel = @selector(method1);
    NSLog(@"sel = %p", sel);
    
#pragma mark - Method Swizzling
    /**
     通过这一技术，可以在运行时通过修改类的分发表中selector对应的函数，来修改方法中的实现。
     在UIViewController (Tracking)这个分类中，就使用到了Swizzling技术，从而可以跟踪ViewController展示给用户的次数。
     Swizzling应该总是在+load方法中执行。
     Swizzling应该总是在dispatch_once中执行。
     */
    
#pragma mark - 协议&分类
}

@end

