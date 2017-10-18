//
//  JQMyAlbumModel.m
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "JQMyAlbumModel.h"
#import "MD5Tool.h"

@implementation JQMyAlbumModel


-(instancetype)init
{
    if (self=[super init]) {
        
        NSDate *date=[NSDate date];
        
        NSLog(@"%@",date);//2015-11-20 00:37:40 +0000
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
        
        dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
        
        NSLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20 08:24:04
        self.makeTime=[dateFormatter stringFromDate:date];
//        self.albumType=JQ3DLayoput;
        self.AlbumModelId=[MD5Tool md5:self.makeTime];
    }
    return self;
}



@end
