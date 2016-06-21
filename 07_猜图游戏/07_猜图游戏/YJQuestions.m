//
//  YJQuestions.m
//  07_猜图游戏
//
//  Created by alen on 16/6/18.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "YJQuestions.h"

@implementation YJQuestions

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.answer = dict[@"answer"];
        self.icon = dict[@"icon"];
        self.title = dict[@"title"];
        self.options = dict[@"options"];
    }
    return self;
}
+(instancetype)questionsWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
