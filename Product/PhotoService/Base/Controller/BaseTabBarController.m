//
//  BaseTabBarController.m
//  Artisan
//
//  Created by cguo on 2017/6/21.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "PhotoViewController.h"//图片
#import "AlbumViewController.h"//相册

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor=[UIColor colorWithRed:37.0/255.0 green:99.0/255.0 blue:243.0/255.0 alpha:1];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initViewWitnNav];
    self.delegate=self;
    
}
+(void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    UITabBarItem *item=[UITabBarItem appearance];
    //设置tabaritem的正常情况下的属性
    NSMutableDictionary *textArr=[NSMutableDictionary dictionary];
    textArr[NSForegroundColorAttributeName]=[UIColor lightGrayColor];//文字颜色
    
    [item setTitleTextAttributes:textArr forState:UIControlStateNormal];
    
    //设置tabaritem的选中情况下的属性
    NSMutableDictionary *selecttextArr=[NSMutableDictionary dictionary];
    selecttextArr[NSFontAttributeName] = textArr[NSFontAttributeName];
    selecttextArr[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    [item setTitleTextAttributes:selecttextArr forState:UIControlStateSelected];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initViewWitnNav
{
  //在这里添加tabbar上对应的控制器
    PhotoViewController *service=[[PhotoViewController alloc]init];
    
    [self addChildVc:service title:@"图片" image:@"tab_Photo" selectedImage:@"tab_Photo_Click"];
    
    
    
    AlbumViewController *me=[[AlbumViewController alloc]init];
    
    [self addChildVc:me title:@"相册" image:@"tab_Alum" selectedImage:@"tab_Alum_Click"];
    
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置子控制器的文字
    //    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    childVc.tabBarItem.title=title;
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // //使用指定渲染模式---总是绘制原始图像
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    //    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    //    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:37.0/255.0 green:99.0/255.0 blue:243.0/255.0 alpha:1];
    //    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    
//    [self setValue:[[baseTabel alloc]init] forKey:@"tabBar"];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    
    // 添加为子控制器
    [self addChildViewController:nav];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
