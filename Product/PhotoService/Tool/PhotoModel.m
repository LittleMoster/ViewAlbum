//
//  PhotoModel.m
//  BusinessiOS
//
//  Created by cguo on 2017/8/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "PhotoModel.h"

#import "YQImageCompressTool.h"
@implementation PhotoModel

-(instancetype)init
{
    if (self=[super init]) {
        
    }
    return self;
}

+(PhotoModel*)GetPhotoModelByPHAsset:(PHAsset*)asset
{
 
   return  [self GetPhotoModelByPHAsset:asset imageSize:CGSizeMake(0, 0)];
}

+(PhotoModel*)GetPhotoModelByPHAsset:(PHAsset*)asset imageSize:(CGSize)imagesize
{
    PhotoModel *model=[[PhotoModel alloc]init];
    model.imageName=[asset valueForKey:@"_filename"];
    
    NSRange rang=[[asset valueForKey:@"_uniformTypeIdentifier"] rangeOfString:@"."];
    model.mimeType=[[asset valueForKey:@"_uniformTypeIdentifier"] substringFromIndex:rang.location+1];
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    model.fileName= [NSString stringWithFormat:@"%@.%@", str,model.mimeType];
    
//    model.image=[self getImageBy:asset imageSize:imagesize];
    //用于修正图片的方向
    model.image=[YQImageCompressTool fixOrientation:model.image];
    
    model.imageSize=[self GetImageSize:asset imageSize:imagesize];
    
//    model.imageData=[YQImageCompressTool OnlyCompressToDataWithImage:model.image FileSize:500];
    
    PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
    options.synchronous = YES;
    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        model.imageData=[YQImageCompressTool CompressToDataWithImgData:imageData FileSize:200];
    }];
    
    //            model.imageData=[YQImageCompressTool OnlyCompressToDataWithImage:[self getImageBy:asset imageSize: model.imageSize] FileSize:500];
    model.image =[UIImage imageWithData:model.imageData];
    
    return model;

}

+(NSMutableArray*)GetPhotoModelArrByPHAssetArr:(NSArray*)PHAssets
{
  return  [self GetPhotoModelArrByPHAssetArr:PHAssets imageSize:CGSizeMake(0, 0)];
}
+(NSMutableArray*)GetPhotoModelArrByPHAssetArr:(NSArray*)PHAssets imageSize:(CGSize)imagesize
{
    NSMutableArray *photoArrM=[NSMutableArray array];
  
        [PHAssets enumerateObjectsUsingBlock:^(PHAsset *  _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
         
            PhotoModel *model=[[PhotoModel alloc]init];
            model.imageName=[asset valueForKey:@"_filename"];
            
            NSRange rang=[[asset valueForKey:@"_uniformTypeIdentifier"] rangeOfString:@"."];
            model.mimeType=[[asset valueForKey:@"_uniformTypeIdentifier"] substringFromIndex:rang.location+1];
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            model.fileName= [NSString stringWithFormat:@"%@.%@", str,model.mimeType];
            
//            model.image=[self getImageBy:asset imageSize:imagesize];
            //用于修正图片的方向
//            model.image=[YQImageCompressTool fixOrientation:model.image];
            
            model.imageSize=[self GetImageSize:asset imageSize:imagesize];
            
                
                PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
                options.synchronous = YES;
             [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                 model.imageData=[YQImageCompressTool CompressToDataWithImgData:imageData FileSize:200];
             }];
              
//            model.imageData=[YQImageCompressTool OnlyCompressToDataWithImage:[self getImageBy:asset imageSize: model.imageSize] FileSize:500];
                model.image =[UIImage imageWithData:model.imageData];
            [photoArrM addObject:model];
                
            }
        }];
        
    return photoArrM;
    
    
    
}

+(CGSize)GetImageSize:(PHAsset *)asset imageSize:(CGSize)imagesize
{
    CGSize assetSize=imagesize;
    
    CGFloat W = asset.pixelWidth;
    CGFloat H = asset.pixelHeight;
    
    if (imagesize.width==0 ||imagesize.height==0) {
        assetSize=CGSizeMake(W, H);
    }

    return assetSize;
}

+ (UIImage *)getImageBy:(PHAsset *)asset imageSize:(CGSize)imagesize
{
    __block UIImage *image = nil;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    
    //同步获取图片,只会返回1张图
    options.synchronous = YES;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    CGSize assetSize=[self GetImageSize:asset imageSize:imagesize];
    //    if (imagesize.width<W  && imagesize.height<H) {
//        assetSize=CGSizeMake(W, H);
//    }
//    CGSize baseSize = CGSizeMake(W, H);//这个参数是取原尺寸的， 展示的时候一般不取原尺寸
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:assetSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
        
        image = result;
        
    }];
    
    return image;
}
@end
