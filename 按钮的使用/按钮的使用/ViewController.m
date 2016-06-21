//
//  ViewController.m
//  按钮的使用
//
//  Created by alen on 16/6/6.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)btn_move:(UIButton *)sender;
- (IBAction)btn_change:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btn_pic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击上下左右都执行该方法
- (IBAction)btn_move:(UIButton *)sender {
    
    //获取frame
    CGRect originFrame = self.btn_pic.frame;
    //给每个button都tag赋不同的值，根据sender.tag来判断点的是那个按钮
    switch (sender.tag) {
        case 10:
            originFrame.origin.y -= 5;
            NSLog(@"向上");
            break;
        case 20:
           originFrame.origin.x += 5;
            NSLog(@"向右");
            break;
        case 30:
            originFrame.origin.y += 5;
            NSLog(@"向下");
            break;
        case 40:
            originFrame.origin.x -= 5;
            NSLog(@"向左");
            break;
        default:
            NSLog(@"出错啦！！！");
            break;
    }
    
    //通过block方式执行动画
    [UIView animateWithDuration:1.0 animations:^{
        self.btn_pic.frame = originFrame;
    }];
    
    
    
    
    //通过bounds方式执行动画
//    //开启动画
//    [UIView beginAnimations:nil context:nil];
//    //设置动画时间
//    [UIView setAnimationCurve:2];
//    
//    //给改变后的图片位置赋值给frame
//    self.btn_pic.frame = originFrame;
//    
//    
//    //提交动画
//    [UIView commitAnimations];
}




- (IBAction)btn_change:(UIButton *)sender {
    
    //获取frame
    CGRect originFrame = self.btn_pic.bounds;
    //根据sender.tag判断是哪个按钮
    switch (sender.tag) {
        case 10:
            
            originFrame.size = CGSizeMake(originFrame.size.height + 5, originFrame.size.width + 5);
            NSLog(@"变大");
            break;
            
         case 20:
            
            originFrame.size = CGSizeMake(originFrame.size.height - 5, originFrame.size.width - 5);
            NSLog(@"变小");
            break;
            
        default:
            
            NSLog(@"出错啦！！！");
            break;
    }
    //给改变后的frame重新赋给frame
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:1];
    
    self.btn_pic.frame = originFrame;
    [UIView commitAnimations];
    
}
@end
