//
//  SysAlbumCell.m
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "SysAlbumCell.h"
#import "SysAlbumModel.h"
#import "Masonry.h"

@interface SysAlbumCell ()
@property(nonatomic,strong)UIImageView *headerImaV;
@property(nonatomic,strong)UILabel *nameLabel;
@end

@implementation SysAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCellView];
    }
    return self;
}

-(void)initCellView
{
    __weak typeof(self)weakself=self;
    self.headerImaV=[[UIImageView alloc]init];
    [self addSubview:self.headerImaV];
    
    [self.headerImaV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.mas_top).with.mas_offset(10);
        make.left.mas_equalTo(weakself.mas_left).with.mas_offset(10);
        make.bottom.mas_equalTo(weakself.mas_bottom).with.mas_offset(-10);
        make.width.equalTo(@(60));
    }];
    
    self.nameLabel=[[UILabel alloc]init];
    self.nameLabel.textAlignment=NSTextAlignmentLeft;
    self.nameLabel.font=MinLabelFont;
    [self addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.mas_centerY);
        make.left.mas_equalTo(weakself.headerImaV.mas_right).with.mas_offset(10);
        make.right.mas_equalTo(weakself.mas_right).with.mas_offset(-10);
        make.height.equalTo(@(25));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setSysAlbMode:(SysAlbumModel *)sysAlbMode
{
    _sysAlbMode=sysAlbMode;
    self.headerImaV.image=_sysAlbMode.AlbumHIma;
    self.nameLabel.text=_sysAlbMode.name;
    
}
@end
