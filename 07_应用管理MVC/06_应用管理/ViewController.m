//
//  ViewController.m
//  06_应用管理
//
//  Created by alen on 16/6/15.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"
#import "YJApp.h"
#import "YJAppView.h"

@interface ViewController ()
@property(nonatomic,strong) NSArray *iconArr;

@end

@implementation ViewController

- (NSArray *)iconArr{
    if (_iconArr.count == 0) {
        
        //加载数据
        //从手机的安装目录中获取plist文件的位置
        NSString *path = [[NSBundle mainBundle] pathForResource:@"appMessage.plist" ofType:nil];
    
        //根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //创建一个对象，把数据放在里面
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //循环把每个字典里面的数据赋给对象
        for (NSDictionary *dict in arrayDict) {
            //创建一个模型
            //YJApp  *model = [[YJApp alloc] init];
            //model.appName = dict[@"appName"];
            //model.picName = dict[@"picName"];
            
            YJApp *model = [[YJApp alloc] initWithDict:dict];
            [arrayModels addObject:model];
        }
        _iconArr = arrayModels;
    }
    return _iconArr;
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
    
    for (int i = 0; i < self.iconArr.count; i++) {
        //从plist文件中获取文本值
        YJApp *appModels = self.iconArr[i];
        NSBundle *rootBundle = [NSBundle mainBundle];
        YJAppView *imgView = [[rootBundle loadNibNamed:@"appView" owner:nil options:nil] lastObject];
        
        //设置行 列间的索引
        int columnsIndex = i % columns;
        int rowIndex = i / columns;
        
        CGFloat appX = marginX + columnsIndex * (marginX + appW);
        CGFloat appY = marginY + rowIndex * (marginY + appH);
        //定义空间的位置
        imgView.frame = CGRectMake(appX, appY, appW, appH);
        
        //将创建的空间加入到view里
        [self.view addSubview:imgView];
        
        //向控件添加数据
        imgView.model = appModels;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//下载
- (void)download{
    
}
@end
