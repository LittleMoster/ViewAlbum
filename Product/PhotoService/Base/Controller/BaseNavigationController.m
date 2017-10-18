//
//  BaseNavigationController.m
//  Artisan
//
//  Created by cguo on 2017/6/21.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //        设置左边的返回按钮
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        btn.size = CGSizeMake(70, 30);
        // 让按钮的内容往左边偏移10
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //让按钮中的内容全部往左对齐
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchDown];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    }
    [super pushViewController:viewController animated:animated];
}

-(void)leftClick
{
    [self popViewControllerAnimated:YES];
}
@end
