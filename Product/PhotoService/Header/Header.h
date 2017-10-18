//
//  Header.h
//  PhotoService
//
//  Created by cguo on 2017/10/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#ifndef Header_h
#define Header_h

//沙盒的各个路径    苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
#define DocumentsPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
// 获取Cache目录
#define  CachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

//系统相册归档路径
#define SysAlbumDataPath [DocumentsPath stringByAppendingPathComponent:@"SysAlbumModel.plist"]

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define __weakSelf __weak typeof(self)weakSelf=self;

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define iPhone4sHight 480
#define iPhone5sHight 568
#define iPhone5sWigtht 320
#define iPhone6sHight 667
#define iPhone6sWidth 375
#define MainColor [UIColor colorWithhexString:@"#ffcf38"]  //APP主体颜色
#define DisColor [UIColor colorWithhexString:@"#8e8e8e"] //APP中未选中的颜色
#define LinkColor [UIColor colorWithhexString:@"#1296db"]  //APP分割线颜色
#define BgColor [UIColor colorWithhexString:@"#efefef"]//背景颜色
#define GraylblColor [UIColor colorWithhexString:@"#bbbcbe"]//灰色的文字颜色
#define BlacklblColor [UIColor colorWithhexString:@"#7b7b7b"]//黑色的文字颜色

#define HeigheScale  ScreenHeight/iPhone6sHight
#define WidthScale   ScreenWidth/iPhone6sWidth
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MminLabelFont [UIFont systemFontOfSize:12]
#define MinLabelFont [UIFont systemFontOfSize:13]//字体大小
#define MidLabelFont [UIFont systemFontOfSize:15]//中等字体大小
#define BigLabelFont [UIFont systemFontOfSize:17]//中等字体大小

//新建相册时的相册描述的默认提醒文字
#define AlbumDetialStr @"请描述相册背后的精彩故事"


//新浪
#define SinaSDK_AppId @"4211324564"
#define SinaSDK_Secret @"825297063b8d4bb2a8315edcd8c750a4"

//qq分享
#define QQSDK_AppId @"101425444"
#define QQSDK_Secret @"4021c16f2d9d3a9b4a5af73f2cb2687f"
//微信分享
#define WeiXinSDK_AppId @"wx59d32b2c3595e21b"
#define WeiXinSDK_Secret @"bf2394789ff97e326a95f704d82bb37d"

//app分享出去的回调地址
#define SDKredirectUri @"http://ms.yonxin.com"

#endif /* Header_h */
