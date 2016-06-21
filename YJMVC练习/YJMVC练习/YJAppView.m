//
//  YJAppView.m
//  YJMVC练习
//
//  Created by alen on 16/6/17.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "YJAppView.h"

@interface YJAppView()

@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lbl_appName;
@property (weak, nonatomic) IBOutlet UIButton *btn_download;
- (IBAction)btn_downloadClick:(UIButton *)sender;

@end

@implementation YJAppView

- (void)setModel:(YJAppModel *)model{
    //先赋值
    _model = model;
    
    //解析模型数据，把模型数据赋值给UIView各个子控件
    self.img_icon.image = [UIImage imageNamed:model.icon];
    self.lbl_appName.text = model.name;
}

+ (instancetype)appView{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    return [[rootBundle loadNibNamed:@"YJAppView" owner:nil options:nil] lastObject];
}
- (IBAction)btn_downloadClick:(UIButton *)sender {
    //创建一个用于显示的lable
    UILabel *lblShow = [[UILabel alloc] init];
    sender.enabled = NO;
    sender.backgroundColor = [UIColor grayColor];
    CGFloat viewW = self.superview.frame.size.width;
    CGFloat viewH = self.superview.frame.size.height;
    
    //设置lable的位置、大小
    CGFloat mgsW = 200;
    CGFloat mgsH = 30;
    CGFloat mgsX = (viewW - mgsW) / 2;
    CGFloat mgsY = (viewH - mgsH) / 2;
    
    lblShow.frame = CGRectMake(mgsX, mgsY, mgsW, mgsH);
    
    //设置文字
    lblShow.text = @"正在下载...";
    //设置字体颜色
    lblShow.textColor = [UIColor redColor];
    //设置居中
    lblShow.textAlignment = NSTextAlignmentCenter;
    //设置文字粗体
    lblShow.font = [UIFont boldSystemFontOfSize:17];
    //设置lable的背景颜色
    lblShow.backgroundColor = [UIColor blackColor];
    //设置lable的透明度
//    lblShow.alpha = 0.5;
    
    //设置边框为圆角
    lblShow.layer.cornerRadius = 5;
    //把其他多余的地方裁剪了
    lblShow.layer.masksToBounds = YES;

    //把这个lable添加到view里面显示出来
    [self.superview addSubview:lblShow];
    
    //通过动画渐渐的隐藏lables，一个动画执行完以后执行另一个动画   UIViewAnimationOptionCurveLinear
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        lblShow.alpha = 0.6;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateKeyframesWithDuration:1.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
                lblShow.alpha = 0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [lblShow removeFromSuperview];
                }
            }];
        }
    }];
}
@end
