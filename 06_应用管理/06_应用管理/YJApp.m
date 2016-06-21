//
//  YJApp.m
//  06_应用管理
//
//  Created by alen on 16/6/15.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "YJApp.h"

@implementation YJApp
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.appName = dict[@"appName"];
        self.picName = dict[@"picName"];
    }
    return self;
}

+ (instancetype)appWithDict:(NSDictionary *)dict{
    return  [[self alloc] initWithDict:dict];
}
@end

