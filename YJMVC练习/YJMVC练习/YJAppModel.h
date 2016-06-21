//
//  YJAppModel.h
//  YJMVC练习
//
//  Created by alen on 16/6/17.
//  Copyright © 2016年 alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJAppModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *) dict;
+ (instancetype)appWithDict:(NSDictionary*) dict;

@end
