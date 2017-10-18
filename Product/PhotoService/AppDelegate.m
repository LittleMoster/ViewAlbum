//
//  AppDelegate.m
//  PhotoService
//
//  Created by cguo on 2017/10/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "AppDelegate.h"
//分享相关
#import <ShareSDKConnector/ShareSDKConnector.h>
// 腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDK/ShareSDK.h>
// 微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"


#import "BaseTabBarController.h"
#import "ViewController.h"
#import "NSAuthorityManager.h"//权限相关
#import "CustomColorViewController.h"
#import "DrawViewController.h"//画板
#import "PhotoViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BaseTabBarController *base=[[BaseTabBarController alloc]init];
//    CustomColorViewController *base=[[CustomColorViewController alloc]init];
//    DrawViewController *base=[[DrawViewController alloc]init];
//    ViewController *base=[[ViewController alloc]init];
//    PhotoViewController *base=[[PhotoViewController alloc]init];
    self.window.rootViewController=base;
    [self.window makeKeyWindow];

    [self IsCanGetPhoto];
    return YES;
}

-(void)IsCanGetPhoto
{
    if ([NSAuthorityManager isObtainPhPhotoAuthority]) {
        NSLog(@"已经开启相册权限");
    }else{
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusDenied) {
            DLog(@"相册权限:用户拒绝开启权限(Denied)");
          
        }else if (status == PHAuthorizationStatusNotDetermined){
            DLog(@"相册权限:未选择权限(NotDetermined)");
        
        }else if (status == PHAuthorizationStatusRestricted){
            DLog(@"相册权限:未授权(Restricted)");
   
        }

    }

}
#pragma mark - ShareSDK配置
- (void)initShareSDK
{
    
    [ShareSDK  registerActivePlatforms:@[
                                         @(SSDKPlatformTypeSinaWeibo),
                                         @(SSDKPlatformTypeSMS),
                                         @(SSDKPlatformTypeCopy),
                                         @(SSDKPlatformTypeWechat),
                                         @(SSDKPlatformTypeQQ)]
                              onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                       onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:SinaSDK_AppId
                                           appSecret:SinaSDK_Secret
                                         redirectUri:SDKredirectUri
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WeiXinSDK_AppId
                                       appSecret:WeiXinSDK_Secret];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQSDK_AppId
                                      appKey:QQSDK_Secret
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    [WXApi registerApp:WeiXinSDK_AppId];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
