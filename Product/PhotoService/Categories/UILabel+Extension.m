//
//  UILabel+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UILabel+Extension.h"
#import "UIView+Extension.h"

@implementation UILabel (Extension)

//为指定文字添加点击事件
-(void)addActionStr:(NSString*)text Target:(id)target Action:(SEL)action
{
    
}
-(void)setlightText:(NSString *)str showTextColor:(UIColor*)color ForeOrBack:(ForeOrBackType)colorType
{
    NSString *labelColorType;
    if (colorType==NSForegroundColor) {
        labelColorType=NSForegroundColorAttributeName;
    }else
    {
        labelColorType=NSBackgroundColorAttributeName;
    }
    
    NSRange index=[self.text rangeOfString:str];
//    NSMutableAttributedString *butedString = [[NSMutableAttributedString alloc]initWithString:self.text];
   NSMutableAttributedString *butedString =  [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    if (index.length!=0) {
        
        
        //设置：在3~length-3个单位长度内的内容显示成橙色
        [butedString addAttribute:labelColorType value:color range:NSMakeRange(index.location, index.length)];
        
        BOOL success=YES;
        while (success) {
            if ((index.length+index.location)<self.text.length &&(self.text.length-index.length-index.location)>str.length) {
                
                
                NSString *laststr=[self.text substringFromIndex:index.length+index.location];
                
                NSRange rang= [laststr rangeOfString:str];
                
                index.location=index.location+index.length+rang.location;
                if (index.length!=0  &&index.location<self.text.length) {
                    [butedString addAttribute:labelColorType value:color range:index];

                }
                
                
            }else
            {
                success=NO;
            }
        }
        
    }
    
    self.attributedText= butedString;
    
}

-(void)setlightText:(NSString *)str showTexFont:(UIFont*)font {
    NSString *labelColorType;
 
    
    NSRange index=[self.text rangeOfString:str];
    //    NSMutableAttributedString *butedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSMutableAttributedString *butedString =  [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    if (index.length!=0) {
        
        
        //设置：在3~length-3个单位长度内的内容显示成橙色
        [butedString setAttributes:@{NSFontAttributeName :font} range:index];
        
        BOOL success=YES;
        while (success) {
            if ((index.length+index.location)<self.text.length &&(self.text.length-index.length-index.location)>str.length) {
                
                
                NSString *laststr=[self.text substringFromIndex:index.length+index.location];
                
                NSRange rang= [laststr rangeOfString:str];
                
                index.location=index.location+index.length+rang.location;
                if (index.length!=0  &&index.location<self.text.length) {
                   [butedString setAttributes:@{NSFontAttributeName :font} range:index];
                    
                }
                
                
            }else
            {
                success=NO;
            }
        }
        
    }
    
    self.attributedText= butedString;
    
}


//为label添加点击事件
-(void)addLabelTarget:(id)target action:(SEL)action
{
    self.enabled=YES;
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    
    [self addGestureRecognizer:tapGesture];
}

-(CGFloat)getLabelHeight
{
    self.numberOfLines=0;
        CGSize maxSize=CGSizeMake(self.bounds.size.width, MAXFLOAT);
      CGFloat LabeltextH=[self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.height;

    return LabeltextH;
}
-(void)setText:(NSString *)textStr addAttribute:(NSString *)Attribute value:(id)value
{
    NSRange index=[self.text rangeOfString:textStr];
    //    NSMutableAttributedString *butedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSMutableAttributedString *butedString =  [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    if (index.length!=0) {
        
        
        //设置：在3~length-3个单位长度内的内容显示成橙色
        [butedString addAttribute:Attribute value:value range:NSMakeRange(index.location, index.length)];
        
        BOOL success=YES;
        while (success) {
            if ((index.length+index.location)<self.text.length &&(self.text.length-index.length-index.location)>textStr.length) {
                
                
                NSString *laststr=[self.text substringFromIndex:index.length+index.location];
                
                NSRange rang= [laststr rangeOfString:textStr];
                
                index.location=index.location+index.length+rang.location;
                if (index.length!=0  &&index.location<self.text.length) {
                    [butedString addAttribute:Attribute value:value range:index];
                    
                }
                
                
            }else
            {
                success=NO;
            }
        }
        
    }
    
    self.attributedText= butedString;

}
-(void)setText:(NSString *)textStr setFont:(UIFont *)font
{
    
    NSRange index=[self.text rangeOfString:textStr];
    //    NSMutableAttributedString *butedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSMutableAttributedString *butedString =  [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    if (index.length!=0) {
        
        
        //设置：在3~length-3个单位长度内的内容显示成橙色
        [butedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(index.location, index.length)];
        
        BOOL success=YES;
        while (success) {
            if ((index.length+index.location)<self.text.length &&(self.text.length-index.length-index.location)>textStr.length) {
                
                
                NSString *laststr=[self.text substringFromIndex:index.length+index.location];
                
                NSRange rang= [laststr rangeOfString:textStr];
                
                index.location=index.location+index.length+rang.location;
                if (index.length!=0  &&index.location<self.text.length) {
                    [butedString addAttribute:NSFontAttributeName value:font range:index];
                    
                }
                
                
            }else
            {
                success=NO;
            }
        }
        
    }
    
    self.attributedText= butedString;
    
}
/*
-(void)setLightText:(NSAttributedString *)lightText
{
    self.attributedText=lightText;
}
-(NSAttributedString *)lightText
{
    
  
    return self.attributedText;
}
 */
-(void)setCanCopy
{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
    
    // 关键在这一行，双击手势确定监测失败才会触发单击手势的相应操作
//    [self.zy_Tapsture requireGestureRecognizerToFail:doubleRecognizer];
}
-(void)labelClick
{
    [self becomeFirstResponder];
    
    // 获得菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 设置菜单内容，显示中文，所以要info.plist手动设置app支持中文
        menu.menuItems = @[
                           [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)],
                            [[UIMenuItem alloc] initWithTitle:@"剪切" action:@selector(cat:)]
                           ];
    //
    // 菜单最终显示的位置
    [menu setTargetRect:self.bounds inView:self];
    
    // 显示菜单
    [menu setMenuVisible:YES animated:YES];

}
/**
 * 让Label具备成为第一响应者的资格
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ( (action == @selector(cat:) && self.text)) // 需要有文字才能支持复制
    
       return YES;
    if ( (action == @selector(copyText:) && self.text)) // 需要有文字才能支持复制
        
        return YES;
    return NO;
}
- (void)cat:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
    self.text=@"";
    NSLog(@"%@", [UIPasteboard generalPasteboard].string);
}
- (void)copyText:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;

    NSLog(@"%@", [UIPasteboard generalPasteboard].string);
}

@end
