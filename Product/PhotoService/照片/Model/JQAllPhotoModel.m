//
//  JQAllPhotoModel.m
//  PhotoService
//
//  Created by cguo on 2017/10/18.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "JQAllPhotoModel.h"
#import "MD5Tool.h"

@implementation JQAllPhotoModel


-(instancetype)init
{
    if (self=[super init]) {
        
        NSDateFormatter *foram=[[NSDateFormatter alloc]init];
        foram.dateFormat=@"yyyy-mm-dd HH:mm:ss";
        
        NSString *timeStr=[foram stringFromDate:[NSDate date]];
        self.PhotoID=[MD5Tool md5:timeStr];
    }
    return self;
}
@end
