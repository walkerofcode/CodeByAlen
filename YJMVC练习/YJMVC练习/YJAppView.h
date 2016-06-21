//
//  YJAppView.h
//  YJMVC练习
//
//  Created by alen on 16/6/17.
//  Copyright © 2016年 alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJAppModel.h"

@interface YJAppView : UIView
@property (nonatomic,strong) YJAppModel *model;
+ (instancetype)appView;
@end

