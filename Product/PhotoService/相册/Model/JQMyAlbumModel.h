//
//  JQMyAlbumModel.h
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    JQWaterLayout,
    JQ3DLayoput,
    JQBannerLayout,
} LayoutType;
/*
 **我的相册模型类
 */
@interface JQMyAlbumModel : NSObject

/*
 **模型Id,用于对数据库进行操作，增删改查,默认为创建时间的MD5
 */
@property (nonatomic, strong) NSString  *AlbumModelId;
/*
**相册封面图片
*/
@property (nonatomic, strong) NSString *HeaderImaStr;
/*
 **相册名字
 */
@property (nonatomic, strong) NSString *AlbumName;
/*
 **相册描述
 */
@property (nonatomic, strong) NSString *Albumdatiel;

/*
 **创建日期
 */
@property (nonatomic, strong) NSString *makeTime;

/*
 **布局类型
 */
//@property (nonatomic, assign) LayoutType albumType;
/*
 **图片数组的NSString类型的数据（NSString类型）
 */
@property (nonatomic, strong) NSString *ImageString;

@end
