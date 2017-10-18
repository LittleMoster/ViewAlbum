//
//  PhotoMainView.h
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PhotoMainViewDelegate <NSObject>

/// tableView中点击cell的代理
- (void)cellDidClick:(NSIndexPath *)indexPath params:(NSArray *)params;


@end

@interface PhotoMainView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *MainCollectionV;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) id<PhotoMainViewDelegate> delegate;




/*
 **初始化view
 */
//- (instancetype)initWithFrame:(CGRect)frame;
/*
 **初始化cell
 */
- (void)registerCellClass:(Class)cellClass;
/*
 **初始化数据
 */
- (void)configWithData:(id)data;


@end
