//
//  JQAddAlbumVC.h
//  PhotoService
//
//  Created by cguo on 2017/10/16.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JQAddAlbumVCdelegate <NSObject>

-(void)SuccessAddAlbumSql;

@end

@interface JQAddAlbumVC : UIViewController

@property (nonatomic, assign) id<JQAddAlbumVCdelegate> delegate;
@end
