//
//  ViewController.m
//  动态创建按钮
//
//  Created by alen on 16/6/11.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"点我啊" forState:UIControlStateNormal];
    [button setTitleColor:@"点我干嘛" forState:UIControlStateHighlighted];
    UIImage *boy = [UIImage imageNamed:@"boy"];
    [button setBackgroundImage:boy forState:UIControlStateNormal];
    
    button.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:button];
    
    
    
    
    
    
//    //创建了一个自定义的按钮
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    //设置普通状态下和高亮状态下的按钮标题
//    [button setTitle:@"点我啊" forState:UIControlStateNormal];
//    [button setTitle:@"点我干嘛" forState:UIControlStateHighlighted];
//    
//    //加载图片
//    UIImage *boyImage = [UIImage imageNamed:@"boy"];
//    UIImage *girlImage = [UIImage imageNamed:@"girl"];
//    
//    //设置普通状态下和高亮状态下的按钮背景图片
//    [button setBackgroundImage:boyImage forState:(UIControlStateNormal)];
//    [button setBackgroundImage:girlImage forState:(UIControlStateHighlighted)];
//    
//    //设置普通状态下和高亮状态下的字体颜色
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    
//    //给button设置frame
//    button.frame = CGRectMake(100, 100, 100, 100);
//    
//    //把动态创建的按钮放到view里面
//    [self.view addSubview:button];
//    
//    //添加按钮点击事件
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buttonClick{

    NSLog(@"按钮被点击了！");

}
@end
