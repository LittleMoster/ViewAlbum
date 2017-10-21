//
//  JQAllPhotoModel.h
//  PhotoService
//
//  Created by cguo on 2017/10/18.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQAllPhotoModel : NSObject


/*
 **图片的data,应为要保存到数据库，所以就用Str类型存储
 */
@property (nonatomic, strong) NSString *ImageDataStr;
/*
 **图片的ID，数据库的增删改查
 */
@property (nonatomic, assign) NSString * PhotoID;




@end
