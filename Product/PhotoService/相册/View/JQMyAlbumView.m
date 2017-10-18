//
//  JQMyAlbumView.m
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "JQMyAlbumView.h"
#import "JQMyAlbumCell.h"
#import "JQMyAlbumModel.h"
#import "JQAddAlbumVC.h"

@interface JQMyAlbumView ()


@end
@implementation JQMyAlbumView
static NSString *const AlbumViewCellID=@"SysAlbumCell";
#pragma mark -- handle data


/*
 **初始化view
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame]) {
        
        self.MainTb = [[UITableView alloc] initWithFrame:frame style:style];
        [self addSubview:self.MainTb];
        self.MainTb.delegate = self;
        self.MainTb.dataSource = self;
        self.MainTb.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.MainTb.rowHeight = UITableViewAutomaticDimension;
        self.MainTb.estimatedRowHeight = 100;
        self.MainTb.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.MainTb.tableFooterView = [UIView new];
        
        [self.MainTb registerClass:[JQMyAlbumCell class] forCellReuseIdentifier:AlbumViewCellID];
    }
    return self;
}

- (void)configWithData:(id)data {
    
    self.dataArr = data;
    [self.MainTb reloadData];
}
-(NSMutableArray *)dataArr
{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array ];
    }
    return _dataArr;
}
#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"添加相册" forState:UIControlStateNormal];
    [btn setTitleColor:MainColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(headerViewClick) forControlEvents:UIControlEventTouchDown];
    btn.frame=CGRectMake(0, 0, ScreenWidth, 40);
    return btn;
}

-(void)headerViewClick
{
    [self.viewController.navigationController pushViewController:[[JQAddAlbumVC alloc]init] animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JQMyAlbumCell *cell=[[JQMyAlbumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AlbumViewCellID ];

    cell.AlbumModel=self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.dataArr.count) {
        return;
    }
    JQMyAlbumModel *Albmodel = self.dataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(CellClickWithIndex:withModel:)]) {
        [self.delegate CellClickWithIndex:indexPath withModel:Albmodel];
    }
}

@end
