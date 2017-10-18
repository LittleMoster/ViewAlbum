//
//  WSColorImageView.h
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSColorImageView : UIImageView

@property (copy, nonatomic) void(^currentColorBlock)(UIColor *color,NSString *rgbStr);
@end
