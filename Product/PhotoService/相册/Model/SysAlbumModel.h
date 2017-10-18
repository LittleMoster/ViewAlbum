//
//  SysAlbumModel.h
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysAlbumModel : NSObject<NSCoding>



@property (nonatomic, strong) UIImage *AlbumHIma;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray  *PhotoArr;
@property(nonatomic,assign)NSUInteger Arrcount;

@end
