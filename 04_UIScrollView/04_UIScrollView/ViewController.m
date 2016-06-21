//
//  ViewController.m
//  04_UIScrollView
//
//  Created by alen on 16/6/13.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    //在私有扩展中创建一个属性
    UIScrollView *_scrollView;
    
}
- (IBAction)down:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(75, 200, 250, 250);
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
    
    //2.创建图片UIImageView(图片)
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"xingkong.jpg"];
    CGFloat imgW = imgView.image.size.width;
    CGFloat imgH = imgView.image.size.height;
    imgView.frame = CGRectMake(0, 0, imgW, imgH);
    [scrollView addSubview:imgView];
    
    //3.设置UIScrollView的属性
    //设置UIScrollView的滚动范围(内容大小)
    scrollView.contentSize = imgView.image.size;
    
    //隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    //用来记录scrollView的位置
    //    scrollView.contentOffset = ;
    
    //去掉弹簧效果
    //    scrollView.bounces = NO;
    
    //增加额外的滚动区域(逆时针,上,左，下，右)
    scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    _scrollView = scrollView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)down:(UIButton *)sender {
    [UIView animateWithDuration:1.0 animations:^{
        CGPoint offset = _scrollView.contentOffset;
        offset.y += 150;
        _scrollView.contentOffset = offset;
    }];
}
@end
