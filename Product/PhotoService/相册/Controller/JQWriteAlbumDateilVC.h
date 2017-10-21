//
//  JQWriteAlbumDateilVC.h
//  PhotoService
//
//  Created by cguo on 2017/10/16.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^getDetialText)(NSString*str);

@interface JQWriteAlbumDateilVC : UIViewController

@property(nonatomic,copy)getDetialText getTextBlock;
@end
