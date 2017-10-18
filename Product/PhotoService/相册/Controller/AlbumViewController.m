//
//  AlbumViewController.m
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "AlbumViewController.h"
#import "SystemAlbumViewController.h"
#import "MyAlbumViewController.h"

@interface AlbumViewController ()<UIScrollViewDelegate>
/** 选择框*/
@property(nonatomic,strong)UIView *titlesView;
/** 底部滑块*/
@property(nonatomic,strong)UIView *indicatorView;
/** 选择框按钮*/
@property(nonatomic,strong)UIButton *selectedButton;
/** 底部scroreView*/
@property(nonatomic,strong)UIScrollView *downScroller;
@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"相册";
    
    //加载滑动条
    [self setupTitlesView];
    
    
    [self setupChildVces];
    
    [self setUpScrollerView];
    
    
}
//设置底部的Scroller
-(void)setUpScrollerView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *downScroller=[[UIScrollView alloc]init];
    
    CGFloat top=CGRectGetMaxY(self.titlesView.frame);
    NSLog(@"%f",top);
    CGFloat buttom=self.tabBarController.tabBar.height;
    
    downScroller.backgroundColor=[UIColor redColor];
    downScroller.frame=CGRectMake(0, top, ScreenWidth, ScreenHeight-buttom-top);
    
    downScroller.delegate=self;
    downScroller.pagingEnabled=YES;
    [self.view insertSubview:downScroller atIndex:0];
    downScroller.contentSize = CGSizeMake(downScroller.width * self.childViewControllers.count, 0);
    
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:downScroller];
    self.downScroller=downScroller;
}
#pragma mark--设置底部滑块的渐变色
-(void)setindicatorViewColor
{
    CAGradientLayer *gradientNavLayer = [CAGradientLayer layer];
    gradientNavLayer.frame =CGRectMake(0, 0, self.indicatorView .width, self.indicatorView .height);
    //设置渐变色（即颜色数组）
    
    gradientNavLayer.colors = @[(id)[UIColor colorWithRed:249.0/255.0 green:223.0/255.0 blue:102.0/255.0 alpha:1].CGColor,
                                (id)[UIColor colorWithRed:244.0/255.0 green:221.0/255.0 blue:88.0/255.0 alpha:1].CGColor,
                                (id)[UIColor colorWithRed:235.0/255.0 green:202.0/255.0 blue:68.0/255.0 alpha:1].CGColor];
    
    //    gradientLayer.colors = @[(id)[UIColor blueColor].CGColor,(id)[UIColor redColor].CGColor];
    //变化位置或变化点
    gradientNavLayer.locations =@[@(0.1f),@(0.4f)];
    
    //渐变方向
    gradientNavLayer.startPoint = CGPointMake(0, 0);
    gradientNavLayer.endPoint = CGPointMake(1, 0);
    [self.indicatorView.layer addSublayer:gradientNavLayer];
    
}

-(void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = TitilesViewH;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    //    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 3;
    indicatorView.y = titlesView.height - indicatorView.height;
    indicatorView.backgroundColor=[UIColor colorWithhexString:@"#41c7db"];
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    //中间的分割线
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2, self.titlesView.height/4, 1, self.titlesView.height/2)];
    view.backgroundColor=[LinkColor colorWithAlphaComponent:0.7];
    [self.titlesView addSubview:view];
    
    // 内部的子标签
    NSArray *titles = @[@"我的相册", @"系统相册"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag=i;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.width;
            //            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorView.centerX = button.centerX;
            [self setindicatorViewColor];
        }
    }
    
    
}
- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.width;
        self.indicatorView.centerX = button.centerX;
        [self setindicatorViewColor];
    }];
    CGPoint offset=self.downScroller.contentOffset;
    offset.x=button.tag*self.downScroller.width;
    [self.downScroller setContentOffset:offset animated:YES];
    
}
- (void)setupChildVces
{
    MyAlbumViewController *MyAlbum = [[MyAlbumViewController alloc] init];
    
    [self addChildViewController:MyAlbum];
    
    SystemAlbumViewController *SystemAlbum = [[SystemAlbumViewController alloc] init];
    
    
    
    [self addChildViewController:SystemAlbum];
    
}
#pragma mark--downScrollerDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
    [scrollView addSubview:vc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    NSLog(@"%ld",index);
    for (UIView *view in self.titlesView.subviews) {
        NSLog(@"%@",view);
    }
    [self titleClick:self.titlesView.subviews[index+2]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
