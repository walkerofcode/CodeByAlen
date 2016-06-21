//
//  YJAppModel.m
//  YJMVC练习
//
//  Created by alen on 16/6/17.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "YJAppModel.h"

@implementation YJAppModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (instancetype)appWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
