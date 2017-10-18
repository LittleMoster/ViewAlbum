//
//  SystemAlbumViewController.m
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "SystemAlbumViewController.h"
#import "SysAlbumTableV.h"
#import "SysAlbumCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "NSAuthorityManager.h"
#import "SysAlbumModel.h"
#import "MJExtension.h"
@interface SystemAlbumViewController ()<SysAlbumTableVDelegate>

@property(nonatomic,strong)SysAlbumTableV *MainView;
@property(nonatomic,strong)SysAlbumModel *AlbumModel;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)NSUInteger AlbumNum;
@end

@implementation SystemAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    NSMutableArray *modeldata  = [NSKeyedUnarchiver unarchiveObjectWithFile:SysAlbumDataPath];
//    if (modeldata!=nil) {
//        NSLog(@"%@",modeldata);
//        
//        [self setUpMainView:modeldata];
//    }
//    //获取系统相册
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [self getOriginalImages];
    });
   
    
   
    
}
//初始化view
-(void)setUpMainView:(NSMutableArray*)data
{
    [self.view addSubview: self.MainView];
    [self.MainView registerCellClass:[SysAlbumCell class]];

    [self.MainView configWithData:data];
}
-(void)cellDidClick:(NSIndexPath *)indexPath params:(NSDictionary *)params
{
    NSLog(@"点击了cell");
    //跳转到图片列表
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(SysAlbumTableV *)MainView
{
    if (_MainView==nil) {
        _MainView=[[SysAlbumTableV alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, self.view.height-64-TabbarHeight) style:UITableViewStylePlain];
        _MainView.delegate=self;
    }
    return _MainView;
}


- (void)getOriginalImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
    }
    
//    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    _AlbumNum=assetCollections.count+1;
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
    
    
}


/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    SysAlbumModel *albumModel=[[SysAlbumModel alloc]init];
    albumModel.name=assetCollection.localizedTitle;
  
    /*
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
//            [albumModel.PhotoArr addObject:result];
            
        }];
    }
    */
//    if (albumModel.PhotoArr.count!=0) {
//         albumModel.AlbumHIma=albumModel.PhotoArr.firstObject;
//    }
//    albumModel.Arrcount=albumModel.PhotoArr.count;
//    
//    [self.dataArr addObject:albumModel];
//    
//    if (self.dataArr.count==_AlbumNum) {
//        [self setUpMainView:self.dataArr];
//         [NSKeyedArchiver archiveRootObject:self.dataArr toFile:SysAlbumDataPath];
//    }
//    [NSKeyedArchiver archiveRootObject:albumModel toFile:SysAlbumDataPath];

    //初始化tableview
    
}

-(NSMutableArray *)dataArr
{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}


@end
