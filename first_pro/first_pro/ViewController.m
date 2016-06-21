//
//  ViewController.m
//  first_pro
//
//  Created by alen on 16/6/7.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)btn_number:(UIButton *)sender;
- (IBAction)btn_clean;
- (IBAction)btn_symbol:(UIButton *)sender;
- (IBAction)compute;

@property (weak, nonatomic) IBOutlet UIButton *btn_num1;


@property (weak, nonatomic) IBOutlet UILabel *lbl_show;
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

- (IBAction)btn_number:(UIButton *)sender {
    
    NSString *Snumber = self.lbl_show.text;
    
    //获取字符串的首字符
    NSString *firstnum = [Snumber substringToIndex:1];
    //首字符转成int类型
    int firstn = [firstnum intValue];
    //判断首字符是否为0
    if (firstn == 0) {
        if([Snumber rangeOfString:@"."].location == NSNotFound){
            //首字符为0就截取0之后的数字
            NSString *othernum = [Snumber substringFromIndex:1];
            Snumber = othernum;
            self.lbl_show.text = Snumber;
        }
    }
    
    //获取所选按钮的值
    switch (sender.tag) {
        case 10:
            self.lbl_show.text = [NSString stringWithFormat:@"%@1",Snumber];
            NSLog(@"1");
            break;
        case 20:
            self.lbl_show.text = [NSString stringWithFormat:@"%@2",Snumber];
            NSLog(@"2");
            break;
        case 30:
            self.lbl_show.text = [NSString stringWithFormat:@"%@3",Snumber];
            NSLog(@"3");
            break;
        case 40:
            self.lbl_show.text = [NSString stringWithFormat:@"%@4",Snumber];
            NSLog(@"4");
            break;
        case 50:
            self.lbl_show.text = [NSString stringWithFormat:@"%@5",Snumber];
            NSLog(@"5");
            break;
        case 60:
            self.lbl_show.text = [NSString stringWithFormat:@"%@6",Snumber];
            NSLog(@"6");
            break;
        case 70:
            self.lbl_show.text = [NSString stringWithFormat:@"%@7",Snumber];
            NSLog(@"7");
            break;
        case 80:
            self.lbl_show.text = [NSString stringWithFormat:@"%@8",Snumber];
            NSLog(@"8");
            break;
        case 90:
            self.lbl_show.text = [NSString stringWithFormat:@"%@9",Snumber];
            NSLog(@"9");
            break;
        case 100:
            self.lbl_show.text = [NSString stringWithFormat:@"%@0",Snumber];
            NSLog(@"0");
            break;
        case 160:
            
            self.lbl_show.text = [NSString stringWithFormat:@"%@.",Snumber];
            break;

        default:
            break;
    }
    
}

- (IBAction)btn_clean {
    //把lbl_show清0
    self.lbl_show.text = [NSString stringWithFormat:@"0"];
}


- (IBAction)btn_symbol:(UIButton *)sender {
    NSString *Snumber = self.lbl_show.text;
    NSLog(@"%@",Snumber);
    switch (sender.tag)
    {
        case 120:
            
            self.lbl_show.text = [NSString stringWithFormat:@"%@/",Snumber];
            NSLog(@"/");
            break;
            
        case 130:
            
            self.lbl_show.text = [NSString stringWithFormat:@"%@*",Snumber];
            NSLog(@"*");
            break;
            
        case 140:
            
            self.lbl_show.text = [NSString stringWithFormat:@"%@-",Snumber];
            NSLog(@"-");
            break;
            
        case 150:
            
            self.lbl_show.text = [NSString stringWithFormat:@"%@+",Snumber];
            NSLog(@"+");
            break;
                default:
            break;
    }
}


//点击＝号触发
- (IBAction)compute {
    //获取文本框的值
    NSString *Snumber = self.lbl_show.text;
    NSString *operators = @"";
    float resultTop = 0;
    float resultDown = 0;
    float result = 0;
    if ([self.lbl_show.text rangeOfString:@"/"].location != NSNotFound) {
        operators = @"/";
        NSLog(@"这个是除法");
    }else if([self.lbl_show.text rangeOfString:@"*"].location != NSNotFound){
        operators = @"*";
        NSLog(@"这个是乘法");
    }else if([self.lbl_show.text rangeOfString:@"+"].location != NSNotFound){
        operators = @"+";
        NSLog(@"这个是加法");
    }else if([self.lbl_show.text rangeOfString:@"-"].location != NSNotFound){
        operators = @"-";
        NSLog(@"这个是减法");
    }else{
        self.lbl_show.text = Snumber;
    }
    if ([operators isEqualToString:@"/"]) {
        
        //获取符号的位置
        NSRange range = [Snumber rangeOfString:@"/" options:NSCaseInsensitiveSearch];
        //获取符号前的字符串
        resultTop = [[Snumber substringToIndex:range.location] intValue];
        //去掉“／”和符号前的数字
        NSString *newString = [Snumber stringByReplacingOccurrencesOfString:[Snumber substringToIndex:range.location] withString:@""];
        NSString *newString1 = [newString stringByReplacingOccurrencesOfString:@"/" withString:@""];
        resultDown = [newString1 intValue];
        result = resultTop/resultDown;
        self.lbl_show.text = [NSString stringWithFormat:@"%@=%.2f",Snumber,result];
        NSLog(@"确定这个是除法");
        
    }else if([operators isEqualToString:@"*"]){
        
        //获取符号的位置
        NSRange range = [Snumber rangeOfString:@"*" options:NSCaseInsensitiveSearch];
        //获取符号前的字符串
        resultTop = [[Snumber substringToIndex:range.location] intValue];
        //去掉“／”和符号前的数字
        NSString *newString = [Snumber stringByReplacingOccurrencesOfString:[Snumber substringToIndex:range.location] withString:@""];
        NSString *newString1 = [newString stringByReplacingOccurrencesOfString:@"*" withString:@""];
        resultDown = [newString1 intValue];
        result = resultTop*resultDown;
        self.lbl_show.text = [NSString stringWithFormat:@"%@=%.2f",Snumber,result];
        NSLog(@"确定这个是乘法");
        
    }else if([operators isEqualToString:@"+"]){
        
        //获取符号的位置
        NSRange range = [Snumber rangeOfString:@"+" options:NSCaseInsensitiveSearch];
        //获取符号前的字符串
        resultTop = [[Snumber substringToIndex:range.location] intValue];
        //去掉“／”和符号前的数字
        NSString *newString = [Snumber stringByReplacingOccurrencesOfString:[Snumber substringToIndex:range.location] withString:@""];
        NSString *newString1 = [newString stringByReplacingOccurrencesOfString:@"+" withString:@""];
        resultDown = [newString1 intValue];
        result = resultTop+resultDown;
        self.lbl_show.text = [NSString stringWithFormat:@"%@=%.2f",Snumber,result];
        NSLog(@"确定这个是加法");
        
    }else if([operators isEqualToString:@"-"]){
        //获取符号的位置
        NSRange range = [Snumber rangeOfString:@"-" options:NSCaseInsensitiveSearch];
        //获取符号前的字符串
        resultTop = [[Snumber substringToIndex:range.location] intValue];
        //去掉“／”和符号前的数字
        NSString *newString = [Snumber stringByReplacingOccurrencesOfString:[Snumber substringToIndex:range.location] withString:@""];
        NSString *newString1 = [newString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        resultDown = [newString1 intValue];
        result = resultTop-resultDown;
        self.lbl_show.text = [NSString stringWithFormat:@"%@=%.2f",Snumber,result];
        NSLog(@"确定这个是减法");
    }
   

}
@end
