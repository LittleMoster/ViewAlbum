//
//  JQPlaceholderTextView.h
//  PhotoService
//
//  Created by cguo on 2017/10/17.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQPlaceholderTextView : UITextView



/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
