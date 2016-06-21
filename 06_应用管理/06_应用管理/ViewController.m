//
//  ViewController.m
//  06_应用管理
//
//  Created by alen on 16/6/15.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"
#import "YJApp.h"

@interface ViewController ()
@property(nonatomic,strong) NSArray *iconArr;

@end

@implementation ViewController

- (NSArray *)iconArr{
    if (_iconArr.count == 0) {
        
        //加载数据
        //从手机的安装目录中获取plist文件的位置
        NSString *path = [[NSBundle mainBundle] pathForResource:@"appMessage.plist" ofType:nil];
        
        NSLog(@"%@",path);
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
        //创建一个UIview
        UIView *appView = [[UIView alloc]  init];
        
        //设置UIview的背景色
        appView.backgroundColor = [UIColor blueColor];
        
        //设置行 列间的索引
        int columnsIndex = i % columns;
        int rowIndex = i / columns;
        
        CGFloat appX = marginX + columnsIndex * (marginX + appW);
        CGFloat appY = marginY + rowIndex * (marginY + appH);
        //定义空间的位置
        appView.frame = CGRectMake(appX, appY, appW, appH);
        
        //将创建的空间加入到view里
        [self.view addSubview:appView];
        
        //在appView里创建imageView
        UIImageView *imgView = [[UIImageView alloc] init];
        NSString *picName = appModels.picName;
        //创建照片对象，并赋值给imgView
        UIImage *img = [UIImage imageNamed:picName];
        imgView.image = img;
        //设置背景颜色
        imgView.backgroundColor = [UIColor brownColor];
        CGFloat picW = 40;
        CGFloat picH = 40;
        imgView.frame = CGRectMake(appX+((appW - picW) / 2), appY,picW,picH);
        [self.view addSubview:imgView];
        
        //在appView里面创建lable
        UILabel *lblText = [[UILabel alloc] init];
        lblText.text = appModels.appName;
        //设置背景颜色
        [lblText setBackgroundColor:[UIColor redColor]];
        CGFloat textW = appW;
        CGFloat textH = 25;
        lblText.frame = CGRectMake(appX, appY+picH, textW, textH);
        //设置文字居中
        [lblText setTextAlignment:NSTextAlignmentCenter];
        //设置字体大小
        [lblText setFont:[UIFont systemFontOfSize:11]];
        [self.view addSubview:lblText];
        
        //在appView里面创建按钮
        UIButton *btnDownload = [[UIButton alloc] init];
        //设置普通状态下的按钮图片
        UIImage *imgDownloadNormal = [UIImage imageNamed:@""];
        UIImage *imgDownloadHighlighted = [UIImage imageNamed:@""];
        [btnDownload setImage:imgDownloadNormal forState:UIControlStateNormal];
        //设置按钮的文字
        [btnDownload setTitle:@"下载" forState:UIControlStateNormal];
        [btnDownload setTitle:@"已安装" forState:UIControlStateHighlighted];
        //设置文字大小与居中
        btnDownload.titleLabel.font = [UIFont systemFontOfSize:11];
        
        //设置按钮的背景颜色
        [btnDownload setBackgroundColor:[UIColor blackColor]];
        //设置高亮状态下的按钮图片
        [btnDownload setImage:imgDownloadHighlighted forState:UIControlStateHighlighted];
        CGFloat btnDownloadW = 40;
        CGFloat btnDownloadH = 25;
        btnDownload.frame = CGRectMake(appX+((appW - btnDownloadW)/2), appY+picH+textH, btnDownloadW, btnDownloadH);
        [self.view addSubview:btnDownload];
        
        //为按钮增加一个点击事件
        [btnDownload addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
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
