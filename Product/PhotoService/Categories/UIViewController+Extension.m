//
//  UIViewController+Extension.m
//  Artisan
//
//  Created by cguo on 2017/6/26.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation UIViewController (Extension)


+(void)load
{
    //我们只有在开发的时候才需要查看哪个viewController将出现
    //所以在release模式下就没必要进行方法的交换，如果release模式下也要的话，请注释
#ifdef DEBUG
//    
//    //原本的viewWillAppear方法
//    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
//    
//    //需要替换成 能够输出日志的viewWillAppear
//    Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));
//    
//    //两方法进行交换
//    method_exchangeImplementations(viewWillAppear, logViewWillAppear);
//    
    //原本的viewWillAppear方法
    Method viewDidDisappear = class_getInstanceMethod(self, @selector(viewDidDisappear:));
    
    //需要替换成 能够输出日志的viewWillAppear
    Method logviewDidDisappear = class_getInstanceMethod(self, @selector(logviewDidDisappear:));
    
    //两方法进行交换
    method_exchangeImplementations(viewDidDisappear, logviewDidDisappear);
    
    
    
    
#endif
}
-(void)logviewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self logviewDidDisappear:animated];
}

-(void)logViewWillAppear:(BOOL)animated
{
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameDidChange:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameWillChange:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view layoutIfNeeded];
    
    NSString *className=NSStringFromClass([self class]);
    
    if ([className hasPrefix:@"UI"]==NO) {
        NSLog(@"现在执行的是%@控制器名称",className);
        [self.view layoutIfNeeded];
    }
    [self logViewWillAppear:animated];
}


//-(void)logViewDidLoad
//{
//    NSString *className=NSStringFromClass([self class]);
//    
//    if ([className hasPrefix:@"UI"]==NO) {
//        NSLog(@"执行了控制器---%@",className);
//    }
//    
//    [self logViewDidLoad];
//}


@end
