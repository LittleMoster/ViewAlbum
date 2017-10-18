//
//  JQMyAlbumView.h
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JQMyAlbumModel;
@protocol JQMyAlbumViewDelegate <NSObject>

-(void)CellClickWithIndex:(NSIndexPath*)indexPath withModel:(JQMyAlbumModel*)model;

@end


@interface JQMyAlbumView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *MainTb;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) id<JQMyAlbumViewDelegate> delegate;


/*
 **初始化view
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
/*
 **初始化数据
 */
-(void)configWithData:(id)data;
@end
