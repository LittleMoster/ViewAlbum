//
//  Base64Image.h
//  BusinessiOS
//
//  Created by cguo on 2017/9/18.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PhotoModel;
@interface Base64Image : NSObject


+(NSString *)ImageToBase64InCSS:(PhotoModel*)ImageData;
+(NSString *)ImageToBase64Bydata:(NSData*)imageData;


+(UIImage *)Base64ToImage:(NSString *)Base64Str;



+(NSData*)GetImageDataWithBase64Str:(NSString *)base64Str;

+(NSMutableArray <NSData*>*)GetImageDataArrWithBase64Str:(NSString*)base64Str;

@end
