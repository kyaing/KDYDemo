//
//  Person.m
//  KDYDemo
//
//  Created by zhongye on 16/3/8.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

#import "MyPersonObject.h"

@implementation MyPersonObject

//归档(将类中的属性编码)
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

//反归档(逆转换为对象)
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, %@, %ld", self.name, self.gender, self.age];
}

@end

