//
//  UIImageView+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    UIControlEventTouch,//点击
    UIControlEventDoubleTouch,
    UIControlEventLongTouch,//长按
    UIControlEventsPinchGesture,//缩放
    UIControlEventsRotationGesture,//旋转
    UIControlEventsRotationGestureAndPinchGesture,//旋转加缩放
    UIcontrolEventsPanGesture
}ImageViewEvents;


@interface UIImageView (Extension)



//如果不需要事件就设置action为nil
-(void)addImageViewTarget:(id)target action:(SEL)action forControlEvents:(ImageViewEvents)controlEvent;
- (UIImageView *)circleImageView;


@property(nonatomic,assign)BOOL PinchEnble;
@property(nonatomic,assign)BOOL RotationEnable;
@property(nonatomic,assign)BOOL PinchAndRotationEnble;
@property(nonatomic,assign)BOOL DoubleTouchEnable;




@end
