//
//  JQWriteAlbumDateilVC.m
//  PhotoService
//
//  Created by cguo on 2017/10/16.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "JQWriteAlbumDateilVC.h"
#import "Masonry.h"
#import "ReactiveObjC.h"
#import "JQPlaceholderTextView.h"

@interface JQWriteAlbumDateilVC ()

@property(nonatomic,strong)JQPlaceholderTextView *textView;

@end

@implementation JQWriteAlbumDateilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BgColor;
    
    [self setNavBarItem];
    
    [self setUpMainView];
    
    

    
    
    
    
}
//加载导航栏
-(void)setNavBarItem
{
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"LeftClick"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightItemClick
{
    //保存输入的值
    
    if (self.getTextBlock) {
        self.getTextBlock(self.textView.text);
    }
   
    //返回
    [self leftItemClick];
    
    
}
-(void)setUpMainView
{
    
    __weakSelf
    self.textView=[[JQPlaceholderTextView alloc]init];
    self.textView.backgroundColor=[UIColor whiteColor];
    self.textView.placeholder=@"请描述相册背后的精彩故事，记录你的点滴";
    
    self.textView.font=MidLabelFont;
    
    
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.mas_offset(84);
        make.left.equalTo(weakSelf.view.mas_left).with.mas_offset(10);
        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-10);
        make.height.equalTo(@(100));
    }];
    [[self.textView rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
