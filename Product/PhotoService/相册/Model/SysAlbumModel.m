//
//  SysAlbumModel.m
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "SysAlbumModel.h"
#import "NSObject+MJCoding.h"

@implementation SysAlbumModel


-(NSMutableArray *)PhotoArr
{
    if (_PhotoArr==nil) {
        _PhotoArr=[NSMutableArray array];
    }
    return _PhotoArr;
}



MJCodingImplementation
@end
