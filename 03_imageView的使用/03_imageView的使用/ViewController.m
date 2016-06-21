//
//  ViewController.m
//  03_imageView的使用
//
//  Created by alen on 16/6/12.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)btn_down;
- (IBAction)btn_up;
@property (weak, nonatomic) IBOutlet UILabel *lbl_index;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIButton *btnDown;
@property (weak, nonatomic) IBOutlet UIButton *btnUp;
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (nonatomic,strong) NSArray *pic;
//自定义索引，用来记录图片第几张
@property(nonatomic,assign) int index;

@end

@implementation ViewController

//-----------------------------------懒加载-----------------------------------
- (NSArray *)pic{
    //获取pic.plist文件的手机安装位置，然后搜索到pic.plist文件到位置  [NSBundle mainBundle]表示获取手机的安装位置的根目录
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pic" ofType:@"plist"];
    //从plist文件中数据读取返回数组
    if (self.pic.count == 0) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        _pic = arr;
    }
    return _pic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_down {
    self.index++;
    [self setData];
}

- (IBAction)btn_up {
    self.index--;
    [self setData];
}
- (void)setData{
    //新建字典，从数组里面拿到数据
    NSDictionary *dict = self.pic[self.index];
    
    //用字典里面的数据给控件赋值
    [_lbl_index setText:[NSString stringWithFormat:@"%d/%ld",self.index+1,self.pic.count]];
    [_lbl_title setText:dict[@"title"]];
    [_img_icon setImage:[UIImage imageNamed:dict[@"icon"]]];
    
    //根据索引判断，索引小于0向左按钮不能点击，索引大于图片张数向右按钮不能点击
    self.btnUp.enabled = (self.index != 0);
    self.btnDown.enabled = (self.index != (self.pic.count-1));
}
@end
