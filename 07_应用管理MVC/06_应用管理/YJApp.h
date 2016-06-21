//
//  YJApp.h
//  06_应用管理
//
//  Created by alen on 16/6/15.
//  Copyright © 2016年 alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJApp : NSObject
@property (nonatomic,copy) NSString *appName;
@property (nonatomic,copy) NSString *picName;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)appWithDict:(NSDictionary *)dict;
@end
