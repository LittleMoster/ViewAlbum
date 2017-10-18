//
//  ArrOffStrByIma.m
//  PhotoService
//
//  Created by cguo on 2017/10/16.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "ArrOffStrByIma.h"
#import <UIKit/UIKit.h>

#import "PhotoModel.h"
#import "Base64Image.h"
#import "YQImageCompressTool.h"

@implementation ArrOffStrByIma

/*
 **图片数组转base64字符串
 */
+(NSString *)ImageArrToBase64Str:(NSArray <PHAsset*>*)arr
{
    __block NSString *imageStr=@"";
    [arr enumerateObjectsUsingBlock:^(PHAsset*  _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
        
       
        PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            NSData *imadata=[YQImageCompressTool CompressToDataWithImgData:imageData FileSize:200];
            NSString *dataStr=[Base64Image ImageToBase64Bydata:imadata];
            if (idx==0) {
                imageStr=[dataStr stringByAppendingString:dataStr];

            }else{
            imageStr=[imageStr stringByAppendingString:dataStr];
            }
            if (idx==arr.count-1) {
                *stop=YES;
            }else{
            imageStr=[imageStr stringByAppendingString:@","];

            }
        }];

        
    }];
    
    return imageStr;
}

@end
