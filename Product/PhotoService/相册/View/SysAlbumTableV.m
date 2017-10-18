//
//  SysAlbumTableV.m
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "SysAlbumTableV.h"
#import "SysAlbumCell.h"

@interface SysAlbumTableV ()
@property (nonatomic, strong) Class cellClass;

@end

static NSString *const SysAlbumCellID=@"SysAlbumCell";

@implementation SysAlbumTableV

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame]) {
        
        self.MTableV = [[UITableView alloc] initWithFrame:frame style:style];
        [self addSubview:self.MTableV];
        self.MTableV.delegate = self;
        self.MTableV.dataSource = self;
        self.MTableV.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.MTableV.rowHeight = UITableViewAutomaticDimension;
        self.MTableV.estimatedRowHeight = 100;
        self.MTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.MTableV.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark -- handle data
- (void)registerCellClass:(Class)cellClass {
    self.cellClass = cellClass;
    [self.MTableV registerClass:cellClass forCellReuseIdentifier:SysAlbumCellID];
}

- (void)configWithData:(id)data {
    
    self.Albumdata = data;
    [self.MTableV reloadData];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Albumdata.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AlbumCellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     SysAlbumCell *cell=[[SysAlbumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self.cellClass description] ];
    cell = [tableView dequeueReusableCellWithIdentifier:SysAlbumCellID forIndexPath:indexPath];
    cell.sysAlbMode=self.Albumdata[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.Albumdata.count) {
        return;
    }
    NSDictionary *cellDict = self.Albumdata[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(cellDidClick:params:)]) {
        [self.delegate cellDidClick:indexPath params:cellDict];
    }
    
}

#pragma mark -- getter
- (NSArray *)Albumdata {
    if (_Albumdata == nil) {
        _Albumdata = [NSArray array];
    }
    return _Albumdata;
}
@end
