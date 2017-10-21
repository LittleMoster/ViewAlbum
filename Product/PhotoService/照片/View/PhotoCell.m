//
//  PhotoCell.m
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "PhotoCell.h"
#import "Masonry.h"
#import "PhotoModel.h"
#import "UIImage+MultiFormat.h"



@interface PhotoCell ()
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation PhotoCell



//-init
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self initCellView];
    }
    return self;
}

-(void)initCellView
{
    self.imageV=[[UIImageView alloc]init];
    self.imageV.contentMode=UIViewContentModeScaleToFill;
    [self addSubview: self.imageV];
    
    __weak typeof(self)weakSlf=self;
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSlf.mas_left);
        make.top.equalTo(weakSlf.mas_top);
        make.bottom.equalTo(weakSlf.mas_bottom);
        make.right.equalTo(weakSlf.mas_right);
    }];
    
    

    
//     UIGraphicsBeginImageContext(self.imageV.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    UIImage *image = [UIImage imageNamed:@"SEL"];
//    CGImageRef cgImage = image.CGImage;
//    CGRect rect = CGRectMake(0, 0, self.imageV.size.width, self.imageV.size.height);
//    CGContextDrawImage(context, rect, cgImage);
//    UIGraphicsEndImageContext();
}
-(void)setImageData:(NSData *)imageData
{
    _imageData=imageData;
    
//    self.imageV.image=[UIImage imageWithData:_imageData];
}

-(void)setPhotomodel:(PhotoModel *)photomodel
{
    _photomodel=photomodel;
//    self.imageV.image=[UIImage sd_imageWithData:_photomodel.imageData];
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.imageV.width,self.imageV.height), NO, 0);
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(con, CGRectMake(0,0,self.imageV.width,self.imageV.height));
//    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
//    CGContextFillPath(con);
//    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    self.imageV.image=im;

    NSLog(@"%ld",_photomodel.imageData.length);
    self.layer.contents = (__bridge id _Nullable)([UIImage sd_imageWithData:_photomodel.imageData].CGImage);
}

-(void)drawImage:(CGContextRef) context :(CGImageRef) image :(CGRect) rect{
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image);
    
    CGContextRestoreGState(context);
}

@end
