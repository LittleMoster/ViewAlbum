//
//  SysAlbumTableV.h
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SysAlbumTableVDelegate <NSObject>

/// tableView中点击cell的代理
- (void)cellDidClick:(NSIndexPath *)indexPath params:(NSDictionary *)params;
/// cell上点击头像代理方法
- (void)cellHeaderIconDidClick:(NSIndexPath *)indexPath params:(NSDictionary *)params;
/// cell上点击“擅长换题”label的代理方法
- (void)cellGoodTopicDidClick:(NSIndexPath *)indexPath params:(NSDictionary *)params;

@end

@interface SysAlbumTableV : UIView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSArray *Albumdata;
@property (nonatomic, strong) UITableView *MTableV;
@property (nonatomic, assign) id<SysAlbumTableVDelegate> delegate;


/*
 **初始化view
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
/*
 **初始化cell
 */
- (void)registerCellClass:(Class)cellClass;
/*
 **初始化数据
 */
- (void)configWithData:(id)data;

@end
