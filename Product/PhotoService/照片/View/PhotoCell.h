//
//  PhotoCell.h
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoModel;
@interface PhotoCell : UICollectionViewCell


@property (nonatomic, strong) NSData *imageData;

@property (nonatomic, strong) PhotoModel *photomodel;
@end
