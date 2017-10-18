//
//  JQMyAlbumCell.m
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "JQMyAlbumCell.h"
#import "Masonry.h"
#import "JQMyAlbumModel.h"
#import "Base64Image.h"
#import "MF_Base64Additions.h"
@interface JQMyAlbumCell ()
/*
 **相册封面图片
 */
@property (nonatomic, strong) UIImageView *HeaderImV;
/*
 **相册名字
 */
@property (nonatomic, strong) UILabel *AlbumNameLbl;
/*
 **相册描述
 */
@property (nonatomic, strong) UILabel *AlbumdatielLbl;

/*
 **创建日期
 */
@property (nonatomic, strong) UILabel *makeTimeLbl;
@end
@implementation JQMyAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initCell];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        [self initCell];
        
    }
    
    return self;
}

-(void)initCell
{
    __weakSelf;
    self.HeaderImV=[[UIImageView alloc]init];
     self.HeaderImV.contentMode=UIViewContentModeScaleToFill;
    [self addSubview: self.HeaderImV];
    
    [self.HeaderImV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.mas_offset(5);
        make.top.equalTo(weakSelf.mas_top).with.mas_offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).with.mas_offset(-5);
        make.width.equalTo(@(AlbumCellH-10));
    }];
    //相册名
    self.AlbumNameLbl=[[UILabel alloc]init];
    self.AlbumNameLbl.textAlignment=NSTextAlignmentLeft;
    self.AlbumNameLbl.font=MidLabelFont;
    self.AlbumNameLbl.textColor=BlacklblColor;
    [self addSubview:self.AlbumNameLbl];
    
    [self.AlbumNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.HeaderImV.mas_top);
        make.left.equalTo(weakSelf.HeaderImV.mas_right).with.mas_offset(5);
        make.right.equalTo(weakSelf.mas_right).with.mas_offset(-10);
        make.height.equalTo(@(25));
        
    }];
    
    //创建日期
    self.makeTimeLbl=[[UILabel alloc]init];
    self.makeTimeLbl.textAlignment=NSTextAlignmentRight;
    self.makeTimeLbl.font=MidLabelFont;
    self.makeTimeLbl.textColor=BlacklblColor;
    [self addSubview:self.makeTimeLbl];
    
    [self.makeTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.HeaderImV.mas_bottom);
        make.left.equalTo(weakSelf.HeaderImV.mas_right).with.mas_offset(5);
        make.right.equalTo(weakSelf.mas_right).with.mas_offset(-10);
        make.height.equalTo(@(25));
        
    }];
    //相册描述
    self.AlbumdatielLbl=[[UILabel alloc]init];
    self.AlbumdatielLbl.textAlignment=NSTextAlignmentLeft;
    self.AlbumdatielLbl.font=MidLabelFont;
    self.AlbumdatielLbl.textColor=BlacklblColor;
    [self addSubview:self.AlbumdatielLbl];
    
    [self.AlbumdatielLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.AlbumNameLbl.mas_bottom);
        make.left.equalTo(weakSelf.HeaderImV.mas_right).with.mas_offset(5);
        make.right.equalTo(weakSelf.mas_right).with.mas_offset(-10);
        make.bottom.equalTo(weakSelf.makeTimeLbl.mas_top);
        
    }];
    
   
    
    
    
    
}

-(void)setAlbumModel:(JQMyAlbumModel *)AlbumModel
{
    _AlbumModel=AlbumModel;
    
    self.AlbumNameLbl.text=[NSString stringFromBase64String:_AlbumModel.AlbumName];
    self.AlbumdatielLbl.text=[NSString stringFromBase64String:_AlbumModel.Albumdatiel];
    self.makeTimeLbl.text=_AlbumModel.makeTime;
    self.HeaderImV.image=[Base64Image Base64ToImage:_AlbumModel.HeaderImaStr];
    
//    NSMutableArray *iamgeArr=[Base64Image GetImageDataArrWithBase64Str:_AlbumModel.ImageString];
}
@end
