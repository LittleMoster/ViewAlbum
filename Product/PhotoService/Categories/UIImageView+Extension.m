//
//  UIImageView+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIImage+Extrnsion.h"
#import "UIView+Extension.h"

@implementation UIImageView (Extension)


-(UIImageView *)circleImageView
{
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.clipsToBounds = YES;
    return self;
}
-(void)addImageViewTarget:(id)target action:(SEL)action forControlEvents:(ImageViewEvents)controlEvent
{

    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    
    self.zy_target=[NSString stringWithFormat:@"%@",[target class]];

    self.zy_selAction=NSStringFromSelector(action);
    
    if (controlEvent==UIControlEventTouch) {//点击
        
        //新建轻拍手势事件类并添加手势事件
       self.zy_Tapsture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:target action:action];
      
        [self addGestureRecognizer:self.zy_Tapsture];
        
        
    }else if (controlEvent==UIControlEventDoubleTouch)//点击两次
    {
    
        self.zy_currentScale=1;
        self.zy_currentRotation=0;
       
      self.image=  [self.image imageByScalingToSize:self.size];
        self.zy_srcImage=self.image;
        self.contentMode=UIViewContentModeCenter;
        self.clipsToBounds  = YES;
      UITapGestureRecognizer*  doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClick:)];
        doubleRecognizer.numberOfTapsRequired = 2; // 双击
        //关键语句，给self.view添加一个手势监测；
        [self addGestureRecognizer:doubleRecognizer];
        
        // 关键在这一行，双击手势确定监测失败才会触发单击手势的相应操作
        [self.zy_Tapsture requireGestureRecognizerToFail:doubleRecognizer];
  
    }else if (controlEvent==UIControlEventLongTouch)//长按
    {

        UILongPressGestureRecognizer* Press = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(LongClickImage:)];
        Press.numberOfTouchesRequired=1;
        [self addGestureRecognizer:Press];
        
    }else if (controlEvent==UIControlEventsPinchGesture)//缩放
    {
   
        self.zy_gesture = [[UIPinchGestureRecognizer alloc]
                           initWithTarget:self action:@selector(scaleImage:)];
        
        self.image=  [self.image imageByScalingToSize:self.size];
        self.zy_srcImage=self.image;
        self.contentMode=UIViewContentModeCenter;
        self.clipsToBounds  = YES;

        [self addGestureRecognizer:self.zy_gesture];
    }else if(controlEvent==UIControlEventsRotationGesture)//旋转
    {
        
        self.image=  [self.image imageByScalingToSize:self.size];
        self.zy_srcImage=self.image;
        self.contentMode=UIViewContentModeCenter;
        self.clipsToBounds  = YES;
        UIRotationGestureRecognizer* Rotation = [[UIRotationGestureRecognizer alloc]
                                        
                                                 initWithTarget:self action:@selector(RotationImage:)];
        
        self.zy_currentScale=1;
        self.zy_currentRotation=0;
        [self addGestureRecognizer:Rotation];
        
 
    }else if (controlEvent==UIControlEventsRotationGestureAndPinchGesture)
    {
        self.image=  [self.image imageByScalingToSize:self.size];
        self.zy_srcImage=self.image;
        self.contentMode=UIViewContentModeCenter;
        self.clipsToBounds  = YES;
        UIRotationGestureRecognizer* Rotation = [[UIRotationGestureRecognizer alloc]
                                                 
                                                 initWithTarget:self action:@selector(RotationImage:)];
        
    self.zy_gesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaleAndRotationImage:)];
        self.zy_currentScale=1;
            self.zy_currentRotation=0;
      [self addGestureRecognizer:self.zy_gesture];
        [self addGestureRecognizer:Rotation];

    }else if (controlEvent==UIcontrolEventsPanGesture)
    {
        //拖动手势
        UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(ChangeViewFrame:)];
        [self addGestureRecognizer:pan];
    }
    
}

//拖动图片
-(void)ChangeViewFrame:(UIPanGestureRecognizer*)panGest
{
    CGPoint beginPoint=[panGest locationInView:self.viewController.view];
    if (panGest.state==UIGestureRecognizerStateChanged) {
        self.center=beginPoint;
    }
   
    if (panGest.state==UIGestureRecognizerStateEnded) {
        if (self.zy_selAction !=nil && self.zy_target !=nil) {
            objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass([self.zy_target  UTF8String]), sel_registerName("alloc")), sel_registerName("init")), sel_registerName([self.zy_selAction UTF8String])) ;
        }

    }
    
}

//长按图片
-(void)LongClickImage:(UILongPressGestureRecognizer*)press
{
    if (press.state==UIGestureRecognizerStateBegan) {
        if (self.zy_selAction !=nil && self.zy_target !=nil) {
            objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass([self.zy_target  UTF8String]), sel_registerName("alloc")), sel_registerName("init")), sel_registerName([self.zy_selAction UTF8String])) ;
        }

    }
    
    
}

//与旋转配合使用的缩放
- (void) scaleAndRotationImage:(UIPinchGestureRecognizer*)gesture
{
    CGFloat scale = gesture.scale;
    // 根据手势处理器的缩放比计算图片缩放后的目标大小
    CGSize targetSize = CGSizeMake(self.zy_srcImage.size.width * scale * self.zy_currentScale,
                                    self.zy_srcImage.size.height * scale * self.zy_currentScale);
    // 对图片进行缩放、旋转
    self.image = [[self.zy_srcImage imageByScalingToSize:targetSize]
                            imageRotatedByRadians:self.zy_currentRotation];
    // 如果手势结束
    if(gesture.state == UIGestureRecognizerStateEnded)
    {
        // 计算结束时候图片的缩放比
        self.zy_currentScale = scale * self.zy_currentScale;
    }
}
//旋转图片
- (void) RotationImage:(UIRotationGestureRecognizer*)gesture
{
    // 获取手势旋转的弧度
    CGFloat rotation = gesture.rotation;
    // 根据当前缩放比计算图片缩放后的目标大小
    CGSize targetSize = CGSizeMake( self.zy_srcImage.size.width * self.zy_currentScale,
                                    self.zy_srcImage.size.height * self.zy_currentScale);
    // 对图片进行缩放、旋转
    self.image = [[self.zy_srcImage imageByScalingToSize:targetSize]
                            imageRotatedByRadians:self.zy_currentRotation + rotation];
    // 如果旋转手势结束
    if(gesture.state == UIGestureRecognizerStateEnded)
    {
        self.zy_currentRotation = self.zy_currentRotation + rotation;
        if (self.zy_selAction !=nil && self.zy_target !=nil) {
            objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass([self.zy_target  UTF8String]), sel_registerName("alloc")), sel_registerName("init")), sel_registerName([self.zy_selAction UTF8String])) ;
        }
    }
}
//点击两次图片
-(void)doubleTapClick:(UITapGestureRecognizer*)doubleTap
{
    
    if (doubleTap.state==UIGestureRecognizerStateBegan) {
        self.zy_currentScale = self.image.size.width / self.zy_srcImage.size.width;
    }
    
    self.zy_currentScale=self.zy_currentScale*1.2;
    CGSize targetSize = CGSizeMake( self.zy_srcImage.size.width  * self.zy_currentScale,
                                   self.zy_srcImage.size.height * self.zy_currentScale);
    
     self.image = [self.zy_srcImage imageByScalingAspectToMinSize:targetSize];
    
    if (self.zy_selAction!=nil &&self.zy_target!=nil) {
        if (doubleTap.state==UIGestureRecognizerStateEnded) {
            
    
                objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass([self.zy_target  UTF8String]), sel_registerName("alloc")), sel_registerName("init")), sel_registerName([self.zy_selAction UTF8String])) ;

       
        }

    }
 }

//缩放图片
- (void) scaleImage:(UIPinchGestureRecognizer*)gesture
{
    
    CGFloat scale = gesture.scale;
    
    // 如果捏合手势刚刚开始
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        // 计算当前缩放比
        self.zy_currentScale = self.image.size.width / self.zy_srcImage.size.width;
        NSLog(@"%f", self.zy_currentScale);
    }
  
    // 根据手势处理的缩放比计算图片缩放后的目标大小
    CGSize targetSize = CGSizeMake( self.zy_srcImage.size.width * scale * self.zy_currentScale,
                                   self.zy_srcImage.size.height * scale * self.zy_currentScale);

    // 对图片进行缩放
    self.image = [self.zy_srcImage imageByScalingAspectToMinSize:targetSize];

    if (gesture.state==UIGestureRecognizerStateEnded) {

      
        if (self.zy_selAction !=nil && self.zy_target !=nil) {
          objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass([self.zy_target  UTF8String]), sel_registerName("alloc")), sel_registerName("init")), sel_registerName([self.zy_selAction UTF8String])) ;
        }
        
    
    }
}
/*
// 在类被加载到运行时的时候，就会执行
+ (void)load {
    
  
    Method originalMethod = class_getInstanceMethod([self class], @selector(setImage:));
    
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(jq_setImage:));
    

    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)jq_setImage:(UIImage *)image {
    
   
//    image=  [image imageByScalingToSize:self.image.size];
//    self.zy_srcImage=image;
//    self.contentMode=UIViewContentModeCenter;
//    self.clipsToBounds  = YES;
    // 调用系统默认的 setImage 方法
  
    [self jq_setImage:image];
//    [self setimageFrame];

}
*/

-(void)setPinchEnble:(BOOL)enable
{
    if (enable) {
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(scaleImage:)];
        self.image=  [self.image imageByScalingToSize:self.size];
        self.zy_srcImage=self.image;
        self.contentMode=UIViewContentModeCenter;
        self.clipsToBounds  = YES;
        
        [self addGestureRecognizer:pinch];

    }
    self.zy_PinchEnble=enable;
}
-(BOOL)PinchEnble
{
    return self.zy_PinchEnble;
}
-(void)setRotationEnable:(BOOL)enable
{
    if (enable) {
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        
        self.image=  [self.image imageByScalingToSize:self.size];
        self.zy_srcImage=self.image;
        self.contentMode=UIViewContentModeCenter;
        self.clipsToBounds  = YES;
        UIRotationGestureRecognizer* Rotation = [[UIRotationGestureRecognizer alloc]
                                                 
                                                 initWithTarget:self action:@selector(RotationImage:)];
        
        self.zy_currentScale=1;
        self.zy_currentRotation=0;
        [self addGestureRecognizer:Rotation];
        

    }
    self.zy_RotationEnable=enable;
}
-(BOOL)RotationEnable
{
    return self.zy_RotationEnable;
}
-(void)setPinchAndRotationEnble:(BOOL)enable
{
    if (enable) {
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        
        self.image=  [self.image imageByScalingToSize:self.size];
        self.zy_srcImage=self.image;
        self.contentMode=UIViewContentModeCenter;
        self.clipsToBounds  = YES;
        UIRotationGestureRecognizer* Rotation = [[UIRotationGestureRecognizer alloc]
                                                 
                                                 initWithTarget:self action:@selector(RotationImage:)];
        
        self.zy_gesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaleAndRotationImage:)];
        self.zy_currentScale=1;
        self.zy_currentRotation=0;
        [self addGestureRecognizer:self.zy_gesture];
        [self addGestureRecognizer:Rotation];
    }
    self.zy_PinchAndRotationEnble=enable;
}
-(BOOL)PinchAndRotationEnble
{
    return self.zy_PinchAndRotationEnble;
}
-(void)setDoubleTouchEnable:(BOOL)DoubleTouchEnable
{
    
    
    self.zy_currentScale=1;
    self.zy_currentRotation=0;
    
    self.image=  [self.image imageByScalingToSize:self.size];
    self.zy_srcImage=self.image;
    self.contentMode=UIViewContentModeCenter;
    //        self.clipsToBounds  = YES;
    UITapGestureRecognizer*  doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClick:)];
    doubleRecognizer.numberOfTapsRequired = 2; // 双击
    //关键语句，给self.view添加一个手势监测；
    [self addGestureRecognizer:doubleRecognizer];
    // 关键在这一行，双击手势确定监测失败才会触发单击手势的相应操作
    [self.zy_Tapsture requireGestureRecognizerToFail:doubleRecognizer];

    self.zy_DoubleTouchEnble=DoubleTouchEnable;
}
-(BOOL)DoubleTouchEnable
{
    return self.zy_DoubleTouchEnble;
}
- (void)setZy_gesture:(id)object {
    objc_setAssociatedObject(self, @selector(zy_gesture), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIPinchGestureRecognizer *)zy_gesture {
    return objc_getAssociatedObject(self, @selector(zy_gesture));
}

- (UITapGestureRecognizer *)zy_Tapsture {
    return objc_getAssociatedObject(self, @selector(zy_Tapsture));
}
- (void)setZy_Tapsture:(id)object {
    objc_setAssociatedObject(self, @selector(zy_Tapsture), object,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(void)setZy_target:(id)object {
    objc_setAssociatedObject(self, @selector(zy_target), object,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (NSString*)zy_target {
    return objc_getAssociatedObject(self, @selector(zy_target));
}
- (void)setZy_selAction:(id)object {
    objc_setAssociatedObject(self, @selector(zy_selAction),object,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (NSString *)zy_selAction {
    return objc_getAssociatedObject(self, @selector(zy_selAction));
}
- (void)setZy_srcImage:(id)object {
    objc_setAssociatedObject(self, @selector(zy_srcImage), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIImage *)zy_srcImage {
    return objc_getAssociatedObject(self, @selector(zy_srcImage));
}
- (void)setZy_currentScale:(CGFloat)currentScale {
    objc_setAssociatedObject(self, @selector(zy_currentScale), @(currentScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)zy_currentScale {
    return [objc_getAssociatedObject(self, @selector(zy_currentScale))floatValue];
}
- (void)setZy_currentRotation:(CGFloat)currentScale {
    objc_setAssociatedObject(self, @selector(zy_currentRotation), @(currentScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)zy_currentRotation {
    return [objc_getAssociatedObject(self, @selector(zy_currentRotation))floatValue];
}

- (void)setZy_PinchEnble:(BOOL)PinchEnble {
    objc_setAssociatedObject(self, @selector(zy_PinchEnble), @(PinchEnble), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)zy_PinchEnble {
    return objc_getAssociatedObject(self, @selector(zy_PinchEnble));
}

- (void)setZy_RotationEnable:(BOOL)RotationEnable {
    objc_setAssociatedObject(self, @selector(zy_RotationEnable), @(RotationEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)zy_RotationEnable {
    return objc_getAssociatedObject(self, @selector(zy_RotationEnable));
}

- (void)setZy_PinchAndRotationEnble:(BOOL)PinchAndRotationEnble {
    objc_setAssociatedObject(self, @selector(zy_PinchAndRotationEnble), @(PinchAndRotationEnble), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)zy_PinchAndRotationEnble {
    return objc_getAssociatedObject(self, @selector(zy_PinchAndRotationEnble));
}

- (void)setZy_DoubleTouchEnble:(BOOL)DoubleTouchEnble {
    objc_setAssociatedObject(self, @selector(zy_DoubleTouchEnble), @(DoubleTouchEnble), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)zy_DoubleTouchEnble {
    return objc_getAssociatedObject(self, @selector(zy_DoubleTouchEnble));
}
@end
