//
//  LXFPencilBrush.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFPencilBrush.h"
#import <objc/runtime.h>

static LXFPencilBrush*PencilBrush;

@implementation LXFPencilBrush

- (void)drawInContext:(CGContextRef)ctx {
    if (self.hasLastPoint) {
        CGContextMoveToPoint(ctx, self.lastPoint.x, self.lastPoint.y);
    } else {
        CGContextMoveToPoint(ctx, self.startPoint.x, self.startPoint.y);
    }
    CGContextAddLineToPoint(ctx, self.endPoint.x, self.endPoint.y);
}

- (BOOL)keepDrawing {
    return YES;
}
+(instancetype)share
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        PencilBrush=[[LXFPencilBrush alloc]init];
        
    });
    
    return PencilBrush;
    

}
@end
