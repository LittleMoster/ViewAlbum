//
//  Base64Image.m
//  BusinessiOS
//
//  Created by cguo on 2017/9/18.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "Base64Image.h"
#import "MF_Base64Additions.h"

#import "PhotoModel.h"

@implementation Base64Image


+(NSString *)ImageToBase64InCSS:(PhotoModel*)imageModel
{
    NSString *Base64ImageStr=[NSString stringWithFormat:@"data:image/%@;base64,",imageModel.mimeType];
    
    NSString *baseImage=[imageModel.imageData base64String];
    Base64ImageStr=[Base64ImageStr stringByAppendingString:baseImage];
    
    NSLog(@"%@",Base64ImageStr);
    return Base64ImageStr;
}

+(NSData*)GetImageDataWithBase64Str:(NSString *)base64Str
{
    return [NSData dataWithBase64String:base64Str];
}

+(NSString *)ImageToBase64Bydata:(NSData*)imageData
{
    
    
    NSString *Base64ImageStr=[imageData base64String];

    
    NSLog(@"%@",Base64ImageStr);
    return Base64ImageStr;
}
+(UIImage *)Base64ToImage:(NSString *)Base64Str
{
    NSData *decodedImageData = [NSData dataWithBase64String:Base64Str];
    
    UIImage *Image = [UIImage imageWithData:decodedImageData];
    return Image;
}

+(NSMutableArray <NSData*>*)GetImageDataArrWithBase64Str:(NSString *)base64Str
{
   __block NSMutableArray *dataArr=[NSMutableArray array];
    NSArray *Arr=[base64Str componentsSeparatedByString:@","];
  
   [Arr enumerateObjectsUsingBlock:^(NSString *  _Nonnull Base64str, NSUInteger idx, BOOL * _Nonnull stop) {
      
       NSData *data=[NSData dataWithBase64String:Base64str];
       if (data!=nil) {
           [dataArr addObject:data];
       }
       
   }];
    
    return dataArr;
    
}



@end
