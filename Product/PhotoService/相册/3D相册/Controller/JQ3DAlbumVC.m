//
//  JQ3DAlbumVC.m
//  PhotoService
//
//  Created by cguo on 2017/10/16.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "JQ3DAlbumVC.h"
#import "YoungSphere.h"
#import "ChildLongPress.h"
#import "ChildGestureRecognizer.h"

#import "JQMyAlbumModel.h"

#import "Base64Image.h"

@interface JQ3DAlbumVC ()

@property(nonatomic,strong)YoungSphere *sphereView;
@property(nonatomic,strong)NSMutableArray *PhotoArrM;

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *titleName; // 标题

@property(nonatomic, strong) NSData *fileData;

@property (nonatomic, strong) NSUserDefaults * userDefault; // 本地保存信息

// 图片位置
@property(nonatomic, assign) NSInteger newflag;
@end

@implementation JQ3DAlbumVC

-(NSMutableArray *)PhotoArrM
{
    if (_PhotoArrM==nil) {
        _PhotoArrM =[NSMutableArray array];
    }
    return _PhotoArrM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.AlbumModel.ImageString.length>0) {
        
         [self add3DAlbumView:[Base64Image GetImageDataArrWithBase64Str:self.AlbumModel.ImageString]];
       
    }
}


-(void)longPressToDo:(ChildLongPress  *)longPress
{
    [_sphereView timerStop];
    
    self.newflag = longPress.flag;
    
//    [self openCamera:longPress.flag];
    
}

-(void)add3DAlbumView:(NSMutableArray*)photoArr
{
    // 调用展示
    self.sphereView = [[YoungSphere alloc] initWithFrame:CGRectMake(20, 64, [UIScreen mainScreen].bounds.size.width-40  , [UIScreen mainScreen].bounds.size.height-64)];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < photoArr.count; i ++) {
        self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setBackgroundImage:[UIImage imageWithData:photoArr[i]] forState:(UIControlStateNormal)];
        _btn.frame = CGRectMake(0, 0, 60, 60);
        [_btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:_btn];
        [_sphereView addSubview:_btn];
        
        _btn.tag = 100 + i;
        // 长按
        ChildLongPress * longPressGr = [[ChildLongPress alloc] initWithTarget:self action:@selector(longPressToDo:)];
        longPressGr.flag = _btn.tag;
        longPressGr.minimumPressDuration = 1.0;
        [_btn addGestureRecognizer:longPressGr];
        
    }
    [_sphereView setCloudTags:array];
    _sphereView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_sphereView];
    
 
    
    
    // 获取Documents的缓存
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSArray *imageArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docPath error:nil];
//    NSLog(@"dic:%@",imageArray);
//    
//    for (NSString *imageName in imageArray) {
//        NSLog(@"imageName:%@",imageName);
//        NSArray *array = [imageName componentsSeparatedByString:@"."]; //从字符.中分隔成2个元素的数组
//        NSLog(@"array:%@",array[0]); //取得名字，去掉后缀
//        
//        UIImage *selfPhoto = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",docPath, imageName]];//读取图片文件
//        
//        // 图片所在展示框的位置
//        NSInteger newNum = [array[0] integerValue];
//        
//        UIButton *tf1 = (UIButton *)[self.view viewWithTag: newNum];
//        [tf1 setBackgroundImage:selfPhoto forState:(UIControlStateNormal)];
    
//    }

}
//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //判断是否正在显示相册相关信息的view
    UILabel *label = [[UILabel alloc]initWithFrame:(CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width, 40))];
    label.text = @"点击标题更改标题，长按图片更换照片";
    label.textAlignment = 1;
    [self.view addSubview:label];
    
    self.userDefault= [NSUserDefaults standardUserDefaults];
    
    
    NSString *firstName = [_userDefault objectForKey:@"firstName"];
    
    // 影集标题
    self.titleName = [[UILabel alloc]initWithFrame:(CGRectMake(0, 80, self.view.frame.size.width, 30))];
    _titleName.userInteractionEnabled = YES;
    _titleName.font = [UIFont boldSystemFontOfSize:21];
    _titleName.textColor = [UIColor redColor];
    _titleName.textAlignment = 1;
    //    [self.view addSubview:_titleName];
    
    if (firstName.length > 0) {
        _titleName.text = firstName;
    }
    else
    {
        _titleName.text = @"我的影集";
    }
    
    
    // 影集重命名


    
    //显示相册相关的一些信息
    
    //隐藏相关的View显示
    
}

// 点击后的效果图
- (void)buttonPressed:(UIButton *)btn
{
    
    CGFloat fixelW = 0.0 ;
    CGFloat fixelH = 0.0 ;
    CGFloat scale = 0.0;
    
    NSString *imageTag = [NSString stringWithFormat:@"%ld.jpg", (long)btn.tag];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",docPath, imageTag]];//读取图片文件
    
    
    if (selfPhoto != nil) {
        fixelW = CGImageGetWidth(selfPhoto.CGImage);
        fixelH = CGImageGetHeight(selfPhoto.CGImage);
        scale = fixelH / fixelW;
    }
    else
    {
        scale = 1.0;
    }
    
    
    [_sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(5, 5*scale);
    } completion:^(BOOL finished) {
        // 放大后显示时长
        [UIView animateWithDuration:3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [_sphereView timerStart];
        }];
    }];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)dealloc
{
    
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
