//
//  ViewController.m
//  YJMVC练习
//
//  Created by alen on 16/6/17.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"
#import "YJAppView.h"
#import "YJAppModel.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray * appModels;
@end

@implementation ViewController

//懒加载appModel的(重写get方法)
- (NSArray *)appModels{
    if (_appModels.count == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AppList.plist" ofType:nil];
        NSArray *modelArr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        
        for (NSDictionary *dict in modelArr) {
            YJAppModel *appModel = [[YJAppModel alloc] initWithDict:dict];
            [models addObject:appModel];
        }
        _appModels = models;
    }
    return _appModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置每行要放多少个应用图标
    int columns = 3;
    //设置app图标的宽和高
    CGFloat appW = 70;
    CGFloat appH = 90;
    
    //设置app距离顶部的高度
    CGFloat marginTop = 30;
    CGFloat viewWidth = self.view.frame.size.width;
    //计算出每个应用图标x轴间的间距
    CGFloat marginX = (viewWidth - columns * appW) / (columns + 1);
    //设置每个应用图标间y轴的间距
    CGFloat marginY = marginTop;
    
    for (int i = 0; i < self.appModels.count; i++) {
        YJAppModel *model = self.appModels[i];
        YJAppView *appView = [YJAppView appView];
        
        //设置行 列间的索引
        int columnsIndex = i % columns;
        int rowIndex = i / columns;
        
        CGFloat appX = marginX + columnsIndex * (marginX + appW);
        CGFloat appY = marginY + rowIndex * (marginY + appH);
        //定义空间的位置
        appView.frame = CGRectMake(appX, appY, appW, appH);
        
        [self.view addSubview:appView];
        
        //添加数据
        appView.model = model;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
