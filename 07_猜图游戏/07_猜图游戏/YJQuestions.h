//
//  YJQuestions.h
//  07_猜图游戏
//
//  Created by alen on 16/6/18.
//  Copyright © 2016年 alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJQuestions : NSObject
@property (nonatomic,copy) NSString *answer;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSArray *options;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) questionsWithDict:(NSDictionary *)dict;

@end
