//
//  JQAddAlbumVC.m
//  PhotoService
//
//  Created by cguo on 2017/10/16.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "JQAddAlbumVC.h"
#import "Masonry.h"
#import "NSObject+DSSimpleKVO.h"
#import "ReactiveObjC.h"
#import "CBPic2ker.h"
#import "JQWriteAlbumDateilVC.h"
#import "JQMyAlbumModel.h"
#import "YQImageCompressTool.h"
#import "Base64Image.h"
#import "ArrOffStrByIma.h"
#import "NSObject+SQLService.h"
#import "MF_Base64Additions.h"

@interface JQAddAlbumVC ()<UITextFieldDelegate,CBPickerControllerDelegate>

@property(nonatomic,strong)UILabel *AlbMiaoShuLbl;
@property(nonatomic,strong)UILabel *photoNumLbl;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UITextField *nameField;
@property(nonatomic,strong)NSArray *photoArr;
@property(nonatomic,strong)NSData *headerImaData;
@end

@implementation JQAddAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=BgColor;
    [self setupMainView];
    
}

#pragma mark--设置渐变色
-(void)setViewGradientColor:(UIView*)GradientView
{
    CAGradientLayer *gradientNavLayer = [CAGradientLayer layer];
    gradientNavLayer.frame =CGRectMake(0, 0, GradientView.width, GradientView .height);
    //设置渐变色（即颜色数组）
    
    gradientNavLayer.colors = @[(id)[UIColor colorWithRed:249.0/255.0 green:223.0/255.0 blue:102.0/255.0 alpha:1].CGColor,
                                (id)[UIColor colorWithRed:244.0/255.0 green:221.0/255.0 blue:88.0/255.0 alpha:1].CGColor,
                                (id)[UIColor colorWithRed:235.0/255.0 green:202.0/255.0 blue:68.0/255.0 alpha:1].CGColor];
    
    //    gradientLayer.colors = @[(id)[UIColor blueColor].CGColor,(id)[UIColor redColor].CGColor];
    //变化位置或变化点
    gradientNavLayer.locations =@[@(0.1f),@(0.4f)];
    
    //渐变方向
    gradientNavLayer.startPoint = CGPointMake(0, 0);
    gradientNavLayer.endPoint = CGPointMake(1, 0);
    [GradientView.layer addSublayer:gradientNavLayer];
    
}
-(void)setupMainView
{
    __weakSelf;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"AddImage"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addHeader) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.mas_offset(84);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70*HeigheScale, 70*HeigheScale));
    }];
    
    UIView *linkView=[[UIView alloc]init];
    linkView.backgroundColor=LinkColor;
    [self.view addSubview:linkView];
    [linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).with.mas_offset(10);
        make.left.equalTo(weakSelf.view.mas_left).with.mas_offset(10);
        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-10);
        make.height.equalTo(@(1));
    }];
    
    
    
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.textColor=BlacklblColor;
    nameLabel.font=MinLabelFont;
    nameLabel.text=@"相册名字";

    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.mas_offset(10);
        make.top.equalTo(linkView.mas_bottom).with.mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 40));
        
    }];
    
    self.nameField=[[UITextField alloc]init];
    self.nameField.delegate=self;
    self.nameField.backgroundColor=[UIColor whiteColor];
    self.nameField.placeholder=@"给相册起个么么哒的名字";
    self.nameField.font=MinLabelFont;
    [[self.nameField rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    [self.view addSubview:self.nameField];
    [ self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).with.mas_offset(5);
        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-10);
        make.height.equalTo(nameLabel.mas_height);
        make.top.equalTo(nameLabel.mas_top);
    }];
    
    
    UIView *linkView1=[[UIView alloc]init];
    linkView1.backgroundColor=LinkColor;
    [self.view addSubview:linkView1];
    [linkView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.mas_offset(5);
        make.left.equalTo(weakSelf.view.mas_left).with.mas_offset(10);
        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-10);
        make.height.equalTo(@(1));
    }];
    
    UILabel *AlbDetialLbl=[[UILabel alloc]init];
    AlbDetialLbl.textAlignment=NSTextAlignmentCenter;
    AlbDetialLbl.textColor=BlacklblColor;
    AlbDetialLbl.font=MinLabelFont;
    AlbDetialLbl.text=@"相册描述";
    
    [self.view addSubview:AlbDetialLbl];
    [AlbDetialLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.mas_offset(10);
        make.top.equalTo(linkView1.mas_bottom).with.mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 40));
        
    }];
    self.AlbMiaoShuLbl=[[UILabel alloc]init];
    self.AlbMiaoShuLbl.textAlignment=NSTextAlignmentRight;
    self.AlbMiaoShuLbl.text=AlbumDetialStr;
    self.AlbMiaoShuLbl.textColor=GraylblColor;
    self.AlbMiaoShuLbl.font=MinLabelFont;
    self.AlbMiaoShuLbl.lineBreakMode=NSLineBreakByTruncatingMiddle;//省略方式
    self.AlbMiaoShuLbl.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AlbMiaoShuLblClick:)];
    [self.AlbMiaoShuLbl addGestureRecognizer:tap];
    [self.view addSubview:self.AlbMiaoShuLbl];
    [self.AlbMiaoShuLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AlbDetialLbl.mas_left).with.mas_offset(5);
        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-10);
        make.height.equalTo(AlbDetialLbl.mas_height);
        make.top.equalTo(AlbDetialLbl.mas_top);

    }];
    
    UILabel *PhotoLabel=[[UILabel alloc]init];
    PhotoLabel.textAlignment=NSTextAlignmentCenter;
    PhotoLabel.textColor=BlacklblColor;
    PhotoLabel.font=MinLabelFont;
    PhotoLabel.text=@"添加照片";
    [self.view addSubview:PhotoLabel];
    [PhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.mas_offset(10);
//        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-10);
         make.size.mas_equalTo(CGSizeMake(60, 40));
        make.top.equalTo(weakSelf.AlbMiaoShuLbl.mas_bottom).with.mas_offset(5);

    }];
    
    self.photoNumLbl=[[UILabel alloc]init];
    self.photoNumLbl.textAlignment=NSTextAlignmentRight;
    self.photoNumLbl.textColor=GraylblColor;
    self.photoNumLbl.font=MinLabelFont;
    self.photoNumLbl.text=@"选择照片";
    [self.view addSubview:self.photoNumLbl];
    self.photoNumLbl.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *numLblGest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePhoto:)];
    [self.photoNumLbl addGestureRecognizer:numLblGest];
    [self.photoNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PhotoLabel.mas_right).with.mas_offset(5);
        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-20);
        make.height.equalTo(nameLabel.mas_height);
        make.top.equalTo(weakSelf.AlbMiaoShuLbl.mas_bottom).with.mas_offset(5);
    }];
    
    UIImageView *rightImaV=[[UIImageView alloc]init];
    rightImaV.image=[UIImage imageNamed:@"right"];
    [self.view addSubview:rightImaV];
    
    [rightImaV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.photoNumLbl.mas_right);
        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-10);
        make.centerY.equalTo(weakSelf.photoNumLbl.mas_centerY);
        make.height.equalTo(@(20));
    }];
    
    
    self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureBtn setTitle:@"新建相册" forState:UIControlStateNormal];
    self.sureBtn.backgroundColor=MainColor;
    [self setViewGradientColor:self.sureBtn];
    
    [self.sureBtn addTarget:self action:@selector(SureBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.sureBtn cicleView];
    [self.view addSubview:self.sureBtn];
    
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.photoNumLbl.mas_bottom).with.mas_offset(10);
        make.right.equalTo(weakSelf.view.mas_right).with.mas_offset(-40);
        make.left.equalTo(weakSelf.view.mas_left).with.mas_offset(40);
        make.height.equalTo(@(50*HeigheScale));
    }];

}

-(void)choosePhoto:(UITapGestureRecognizer*)tag
{
    CBPhotoSelecterController *controller = [[CBPhotoSelecterController alloc] initWithDelegate:self];
    controller.columnNumber = 4;
    controller.maxSlectedImagesCount=50;
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)photoSelecterController:(CBPhotoSelecterController *)pickerController sourceAsset:(NSArray *)sourceAsset {
    
    self.photoArr=sourceAsset;
    self.photoNumLbl.text=[NSString stringWithFormat:@"已选择%d张照片",sourceAsset.count];
}
- (void)photoSelecterDidCancelWithController:(CBPhotoSelecterController *)pickerController {
    
    //弹框提醒
}
-(void)AlbMiaoShuLblClick:(UITapGestureRecognizer*)tag
{
    NSLog(@"点击了相册描述");
//    跳转页面填写相关描述
    
    JQWriteAlbumDateilVC *detail=[[JQWriteAlbumDateilVC alloc]init];
    detail.getTextBlock=^(NSString *detailText)
    {
        NSLog(@"%@",detailText);
        self.AlbMiaoShuLbl.text=detailText;
    };
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark-- 确认新建相册
-(void)SureBtnClick:(UIButton*)btn
{

    
    if (self.nameField.text==nil &&self.nameField.text.length==0) {
        
        
        return;
    }
    
    if (self.photoArr.count==0) {
        return;
    }
    
    
//    1.生成模型
    JQMyAlbumModel *model=[[JQMyAlbumModel alloc]init];
    model.HeaderImaStr=[Base64Image ImageToBase64Bydata:[YQImageCompressTool OnlyCompressToDataWithImage:[UIImage imageNamed:@"SEL"] FileSize:200]];
    model.AlbumName=[self.nameField.text base64String];
    
    model.Albumdatiel= [self.AlbMiaoShuLbl.text==AlbumDetialStr ? @"暂无任何描述":self.AlbMiaoShuLbl.text base64String];
    model.ImageString=[ArrOffStrByIma ImageArrToBase64Str:self.photoArr];
    
    
    
//    2.保存到数据库
    BOOL seccuss= [model SaveDateWithModelInSQL];
    if (seccuss) {
        NSLog(@"保存成功");
          //通知去更新相册列表
        if ([self.delegate respondsToSelector:@selector(SuccessAddAlbumSql)]) {
            [self.delegate SuccessAddAlbumSql];
        }
      
    }
    
//    3.检查是否保存成功
    
//    4.hub显示相关展示
    
    
}

-(NSArray *)photoArr
{
    if (_photoArr==nil) {
        _photoArr=[NSArray array];
    }
    return _photoArr;
}
#pragma mark--设置相册封面
-(void)addHeader
{
    //跳转选择图片
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
