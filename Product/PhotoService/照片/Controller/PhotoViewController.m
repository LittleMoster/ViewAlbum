//
//  PhotoViewController.m
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "PhotoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoMainView.h"
#import <Photos/Photos.h>
#import "PhotoModel.h"
#import "NSObject+SQLService.h"
#import "JQMyAlbumModel.h"

@interface PhotoViewController ()<PhotoMainViewDelegate>
{
    ALAssetsLibrary *library;
}
@property(nonatomic,strong)NSMutableArray *PhotorrM;
@property(nonatomic,strong)PhotoMainView *mainView;

@end

@implementation PhotoViewController

-(NSMutableArray *)PhotorrM
{
    if (_PhotorrM==nil) {
        _PhotorrM =[NSMutableArray array];
    }
    
    return _PhotorrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
//    self.automaticallyAdjustsScrollViewInsets =NO;
    
    self.title=@"爱柚";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self GetALLphotosUsingPohotKit];

    });
//    [self GetALLphotosUsingPohotKit];
   
}

#pragma mark -- iOS 8.0 以上获取所有照片用Photos.h这个库
-(void)GetALLphotosUsingPohotKit
{
    
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        // 是否按创建时间排序
        PHFetchOptions *option = [[PHFetchOptions alloc] init];
        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        PHCollection *collection = smartAlbums[i];
        //遍历获取相册
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
           
                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
                NSArray *assets;
                if (fetchResult.count > 0) {
                    // 某个相册里面的所有PHAsset对象
                    assets = [self getAllPhotosAssetInAblumCollection:assetCollection ascending:YES ];
                    NSArray *photoModelArr=  [PhotoModel GetPhotoModelArrByPHAssetArr:assets imageSize:CGSizeMake(0, 0)];
                    [self.PhotorrM addObjectsFromArray:photoModelArr];
                
            }
        }
    }
   dispatch_async(dispatch_get_main_queue(), ^{
        
        [self setupMainView];
    });
    
}
#pragma mark - <  获取相册里的所有图片的PHAsset对象  >
- (NSArray *)getAllPhotosAssetInAblumCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    // 存放所有图片对象
    NSMutableArray *assets = [NSMutableArray array];
    
    // 是否按创建时间排序
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    
    // 获取所有图片对象
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    // 遍历
    [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:asset];
    }];
    return assets;
}

- (void)getOriginalImages
{

}
//图片点击
-(void)cellDidClick:(NSIndexPath *)indexPath params:(NSArray *)params
{

    //跳转显示view，对图片进行编辑
    
    
}



-(void)setupMainView
{

    self.mainView=[[PhotoMainView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.height)];
    self.mainView.delegate=self;
    [self.mainView configWithData:self.PhotorrM];
   
    [self.view addSubview:self.mainView];
}


@end
