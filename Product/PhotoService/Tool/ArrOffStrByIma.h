//
//  ArrOffStrByIma.h
//  PhotoService
//
//  Created by cguo on 2017/10/16.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface ArrOffStrByIma : NSObject



/*
 **PHAsset图片数组转base64字符串
 */
+(NSString *)ImageArrToBase64Str:(NSArray <PHAsset*>*)arr;


@end
