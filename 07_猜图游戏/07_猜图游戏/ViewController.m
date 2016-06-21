//
//  ViewController.m
//  07_猜图游戏
//
//  Created by alen on 16/6/18.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "ViewController.h"
#import "YJQuestions.h"

@interface ViewController ()

@property (nonatomic,strong)NSArray * questionModels;
//图片索引
@property (nonatomic,assign) int index;
- (IBAction)btn_nextClick;
- (IBAction)btn_toBigPic;
- (IBAction)btn_iconClick:(UIButton *)sender;
- (IBAction)btn_hint:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIView *view_All;
@property (weak, nonatomic) IBOutlet UIButton *btn_toBig;
@property (weak, nonatomic) IBOutlet UILabel *lbl_index;
@property (weak, nonatomic) IBOutlet UIButton *btn_score;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_pic;
@property (weak, nonatomic) IBOutlet UIButton *btn_next;
@property (weak, nonatomic) IBOutlet UIView *view_answer;
@property (weak, nonatomic) IBOutlet UIView *view_options;


//用来引用阴影按钮
@property (weak, nonatomic) UIButton *cover;
//用来记录图片按钮的原始位置
@property (nonatomic,assign) CGRect frame;


@end

@implementation ViewController

//懒加载数据
- (NSArray *)questionModels{
    
    if (_questionModels.count == 0) {
        //取得手机安装路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        //通过路径获取数据
        NSArray *modelArr = [NSArray arrayWithContentsOfFile:path];
        //创建一个可变数组，用于接收数据
        NSMutableArray *models = [NSMutableArray array];
        //从获取数据的数组里遍历字典并加载在可变数组里
        for (NSDictionary *dict in modelArr) {
            YJQuestions *model = [[YJQuestions alloc] initWithDict:dict];
            [models addObject:model];
        }
        _questionModels = models;
    }
    return _questionModels;
}
//重写该方法，可以用于改变状态栏的文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.index = -1;
    [self btn_nextClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击“下一张”按钮事件
- (IBAction)btn_nextClick {
    [self nextQuestion];
//    [self createAnswer];
}

//点击“大图”按钮事件
- (IBAction)btn_toBigPic {
    [self toBig];
}

//中间图片点击事件
- (IBAction)btn_iconClick:(UIButton *)sender {
    if (self.cover == nil) {
        [self toBig];
    }else{
        [self smallImage];
    }
}

//“提示”按钮点击事件
- (IBAction)btn_hint:(UIButton *)sender {
    //1.扣除分数
    [self addScore:-100];
    //2.把所有的answer按钮数据清空
    for (UIButton *btn_answer in self.view_answer.subviews) {
        //让每个按钮都点一下
        [self btn_answerClick:btn_answer];
    }
    //3.从模型中根据索引获取正确答案
    YJQuestions *model = self.questionModels[self.index];
        //截取正确答案中的第一字符
    NSString *firstChar = [model.answer substringToIndex:1];
    for (UIButton *btn_option in self.view_options.subviews) {
        if([firstChar isEqualToString:btn_option.currentTitle]){
            [self btn_optionsClick:btn_option];
            break;
        }
    }
    
}
//下一张
- (void)nextQuestion{
    //1.索引++
    self.index++;
    
    //当索引达到最大时执行
    if (self.index == self.questionModels.count) {
//        NSLog(@"答题完毕！！！");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜通过！" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            self.index = -1;
            [self nextQuestion];
        }];
        // 创建按钮
        // 注意取消按钮只能添加一个
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            // 点击按钮后的方法直接在这里面写
            self.view_answer.userInteractionEnabled = NO;
            self.view_options.userInteractionEnabled= NO;
            NSLog(@"答题完毕！！！");
        }];
        
        // 添加按钮 将按钮添加到UIAlertController对象上
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        //将UIAlertController模态出来 相当于UIAlertView show 的方法
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //2.把所有按钮清除掉     makeObjectsPerformSelector方法作用是这个view里面的每个控件调用@selector（）这里面的方法
    [self.view_answer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view_options.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.view_options.userInteractionEnabled = YES;

    //3.用模型获取数据
    YJQuestions *questions = self.questionModels[self.index];
    //4.根据模型设置数据
    [self settingData:questions];
    
    //5.创建答案按钮
    [self createAnswerButtons:questions];
    
    //6.创建选项按钮
    [self createOptionsButtons:questions];
  }
//图片变大
- (void)toBig{
    self.frame = self.btn_pic.frame;
    self.btn_toBig.titleLabel.text = @"缩小";
    //创建一个按钮
    UIButton *btn_bigPic = [[UIButton alloc] init];
    //设置按钮的大小为屏幕的大小
    btn_bigPic.frame = self.view.bounds;
    //设置按钮的透明度
    btn_bigPic.alpha = 0;
    //设置按钮的背景颜色为黑色
    btn_bigPic.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:btn_bigPic];
    //创建按钮的点击事件
    [btn_bigPic addTarget:self action:@selector(smallImage) forControlEvents: UIControlEventTouchUpInside];
    
    //把控件放到最外层显示
    [self.view_All bringSubviewToFront:self.btn_pic];
    
    self.cover = btn_bigPic;
    //设置放大后的照片大小
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;
    CGFloat iconX = 0;
    CGFloat iconY = (self.view.frame.size.height - iconW) / 2;
    
    [UIView animateWithDuration:0.7 animations:^{
        //设置按钮的透明度
        btn_bigPic.alpha = 0.6;
        self.btn_pic.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }];
    
}

//图片变大后，把图片还原
- (void)smallImage{
    
    self.btn_toBig.titleLabel.text = @"大图";
    [UIView animateWithDuration:1.0 animations:^{
        //把图片按钮位置还原
        self.btn_pic.frame = self.frame;
        //把透明慢慢变为0
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.cover removeFromSuperview];
            self.cover = nil;
        }
    }];
}

//创建答案按钮
- (void)createAnswerButtons:(YJQuestions *)model{
    //取出答案字体个数
    NSInteger len = model.answer.length;
    //创建答案按钮，并设置frame
    CGFloat btnW = 35;
    CGFloat btnH = 35;
    CGFloat margin =  15;
    CGFloat  marginLeft = (self.view.frame.size.width - (len * btnW + (len - 1) * margin)) / 2;
    
    for (int i = 0; i < len; i++) {
        UIButton *btn_answer = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnX = marginLeft + i * (btnW + margin);
        CGFloat btnY = 0;
        btn_answer.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn_answer.backgroundColor = [UIColor whiteColor];
        [btn_answer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //把按钮添加到answerView里面
        [self.view_answer addSubview:btn_answer];
        //为答案按钮注册点击事件
        [btn_answer addTarget:self action:@selector(btn_answerClick:) forControlEvents:UIControlEventTouchUpInside];
    }

}
//创建选项按钮
- (void)createOptionsButtons:(YJQuestions *)model{
    //1.清楚optionView中的所有子控件
    [self.view_options.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //2.获取model里的option里的待选文字数组
    NSArray *options = model.options;
    
    //3.根据待选文字循环创建按钮
    int columns = 8;
    CGFloat marginTop = 35;
    CGFloat btnW = 35;
    CGFloat btnH = 35;
    CGFloat marginX = (self.view.frame.size.width - columns * btnW) / (columns + 1);
    CGFloat marginY = 15;

    for (int i =0; i < options.count; i++) {
        //创建一个按钮
        UIButton *btn_option = [[UIButton alloc] init];
        //给按钮一个tag值
        btn_option.tag = i;
        //设置按钮背景
        [btn_option setBackgroundColor:[UIColor whiteColor]];
        //设置按钮文字
        [btn_option setTitle:options[i] forState:UIControlStateNormal];
        //设置按钮的文字颜色
        [btn_option setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置行与列的索引
        int columnsIndex = i % columns;
        int rowIndex = i / columns;
        
        //设置按钮的frame
        CGFloat btnX = marginX + columnsIndex * (btnW + marginX);
        CGFloat btnY = marginTop + rowIndex * (btnH + marginY);
        
        btn_option.frame = CGRectMake(btnX, btnY, btnW, btnH);
        //把按钮添加到optionsView里面
        [self.view_options addSubview:btn_option];
        //为按钮注册单机事件
        [btn_option addTarget:self action:@selector(btn_optionsClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//答案按钮的点击事件
- (void)btn_answerClick:(UIButton *)sender{
    [self setAnswerButtonColor:[UIColor blackColor]];
    //1.启用optionView中的控件
    self.view_options.userInteractionEnabled = YES;
    //2.把点中按钮的文字在optionView中显示出来
    //循环找到与点击按钮文字一样optionView中的按钮
    for (UIButton *btn_option in self.view_options.subviews) {
        if (sender.tag == btn_option.tag) {
            btn_option.hidden = NO;
            break;
        }
    }
    //3.清空按钮中的文字
    [sender setTitle:nil forState:UIControlStateNormal];

}

//选项按钮的点击事件
- (void)btn_optionsClick:(UIButton *)sender{
    //1.隐藏这个按钮
    sender.hidden = YES;
    NSMutableString *userInput = [NSMutableString string];
    //2.把按钮的text显示到第一个为空的answer按钮中
    //NSString *text = [sender titleForState:UIControlStateNormal];      //获取指定状态下的文字
    NSString *text = sender.currentTitle;  //获取按钮当前状态下的文字
    for (UIButton *btn_answer in self.view_answer.subviews) {
        if (btn_answer.currentTitle == nil) {
            //点击选项按钮的时候，把option按钮的值与tag赋值给answer按钮
            [btn_answer setTag:sender.tag];
            [btn_answer setTitle:text forState:UIControlStateNormal];
            break;
        }
    }
    //3.设置答案按钮是填满的
    BOOL isFull = YES;
    
    for (UIButton *btn_answer in self.view_answer.subviews) {
        if (btn_answer.currentTitle == nil) {
            isFull = NO;
            break;
        }else{
            [userInput appendString:btn_answer.currentTitle];
        }
    }
    
    //4.如果按钮填满了
    if (isFull) {
        //禁止待选按钮点击
        self.view_options.userInteractionEnabled = NO;
        //获取当前题目的正确答案
        YJQuestions *model = self.questionModels[self.index];
            //读取分数
        int score = (int)self.btn_score.tag;
        NSLog(@"%d",score);
        //对比答案是否正确，如果正确，跳转下一题，增加100积分   如果错误把字体的的颜色改为红色
        if ([userInput isEqualToString:model.answer]) {
            [self setAnswerButtonColor:[UIColor blueColor]];
            [self addScore:100];
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
        }else{
            [self setAnswerButtonColor:[UIColor redColor]];
        }
    }
}
//改变answerView中的字体颜色
- (void)setAnswerButtonColor:(UIColor *)color{
    for (UIButton *anwser in self.view_answer.subviews) {
        [anwser setTitleColor:color forState:UIControlStateNormal];
    }
}
//设置控件数据
- (void)settingData:(YJQuestions *)model{
    //设置各个控件的值
    self.lbl_index.text = [NSString stringWithFormat:@"%d/%ld",self.index+1,self.questionModels.count];
    self.lbl_title.text = model.title;
    [self.btn_pic setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    self.btn_next.enabled = (self.index != self.questionModels.count - 1);
}
//加分、减分的方法
- (void)addScore:(int)score{
    //获取现在的分数
    int scoreNow = (int)self.btn_score.tag;
    //在现在的分数基础上加分
    scoreNow = scoreNow + score;
    //设置按钮tag（分数）
    self.btn_score.tag = scoreNow;
    //把现在的分数显示出来
   [self.btn_score setTitle:[NSString stringWithFormat:@"score:%d",scoreNow] forState:UIControlStateNormal];
}
@end
