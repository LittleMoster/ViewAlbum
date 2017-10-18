//
//  PhotoMainView.m
//  PhotoService
//
//  Created by cguo on 2017/10/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "PhotoMainView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoModel.h"
#import "PhotoCell.h"

@interface PhotoMainView ()
@property (nonatomic, strong) Class cellClass;
@end

@implementation PhotoMainView


static NSString *const cellID=@"photoCellId";

/*
 **初始化view
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((ScreenWidth - 50)/3, (ScreenWidth - 50)/3 * 1.5);
        
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 7.5;
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.MainCollectionV=[[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
        self.MainCollectionV.backgroundColor=[UIColor whiteColor];
        self.MainCollectionV.delegate=self;
        self.MainCollectionV.showsVerticalScrollIndicator=NO;
        self.MainCollectionV.alwaysBounceVertical = YES;
        self.MainCollectionV.dataSource=self;
        
        [self.MainCollectionV registerClass:[PhotoCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:self.MainCollectionV];
    }
    return self;
}
/*
 **初始化cell
 */
- (void)registerCellClass:(Class)cellClass
{
    self.cellClass=cellClass;
    [self.MainCollectionV registerClass:cellClass forCellWithReuseIdentifier:cellID];
}
/*
 **初始化数据
 */
- (void)configWithData:(id)data
{
    self.dataArr=data;
    [self.MainCollectionV reloadData];
}
-(NSArray *)dataArr
{
    if (_dataArr==nil) {
        _dataArr=[NSArray array];
    }
    return _dataArr;
}

#pragma mark -UICollectionViewDelegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.dataArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}
// 返回每一组item的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
// 组的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10 ,10 , 10);
}


//创建UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    PhotoCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    
    
    //取出对应的资源数据
    cell.photomodel= self.dataArr[indexPath.row];
    
    //获取到缩略图
    
    //转换为UIImage
//    UIImageView *imageview=[[UIImageView alloc]initWithFrame:cell.bounds];
//    [cell.contentView addSubview:imageview];
//    //显示图片
//    imageview.image = [UIImage imageWithData:result.imageData];
        /**
     *  获取到原始图片
     ALAssetRepresentation *presentation = [result defaultRepresentation];
     CGImageRef resolutionImg = [presentation fullResolutionImage];
     */
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    if ([self.delegate respondsToSelector:@selector(cellDidClick:params:)]) {
        [self.delegate cellDidClick:indexPath params:self.dataArr];
    }
}

@end
