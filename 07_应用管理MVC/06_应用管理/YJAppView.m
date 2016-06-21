//
//  YJAppView.m
//  06_应用管理
//
//  Created by alen on 16/6/16.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "YJAppView.h"
#import "YJApp.h"

@interface YJAppView()

@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lbl_appName;
@property (weak, nonatomic) IBOutlet UIButton *btn_download;
- (IBAction)btn_dl;

@end

@implementation YJAppView

//重写YJApp－model属性的set方法
- (void)setModel:(YJApp *)model{
    
    //先赋值
    _model = model;
    
    //解析模型数据，把模型数据赋值给UIView各个子控件
    self.img_icon.image = [UIImage imageNamed:model.picName];
    self.lbl_appName.text = model.appName;
}

- (IBAction)btn_dl {
    NSLog(@"download");
//    self.btn_download.titleLabel.text = @"已下载";
    self.btn_download.backgroundColor = [UIColor redColor];
    self.btn_download.enabled = NO;
}
@end
