//
//  UILabel+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    NSForegroundColor ,//前景色
    NSBackgroundColor   //背景色
}ForeOrBackType;
@interface UILabel (Extension)

-(void)setCanCopy;

//为label添加点击事件
-(void)addLabelTarget:( id)target action:(SEL)action;


-(CGFloat)getLabelHeight;

//@property(strong,nonatomic)NSAttributedString *lightText;

/**
 *设置特定文字的颜色（背景色或前景色）
 */
-(void)setlightText:(NSString *)str showTextColor:(UIColor*)color ForeOrBack:(ForeOrBackType)colorType;

/**
 *设置指定文字的大小
 */
-(void)setText:(NSString*)textStr setFont:(UIFont*)font;

/**
 *设置指定文字改变其属性 textStr为需要改变的指定文字
 */
-(void)setText:(NSString*)textStr addAttribute:(NSString *)Attribute value:( id)value ;

-(void)addActionStr:(NSString*)text Target:(id)target Action:(SEL)action;
/**
 *改变指定文字的字体大小
 */
-(void)setlightText:(NSString *)str showTexFont:(UIFont*)font ;
@end
