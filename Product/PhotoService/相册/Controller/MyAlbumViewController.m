//
//  MyAlbumViewController.m
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "MyAlbumViewController.h"

#import "JQMyAlbumView.h"
#import "JQAddAlbumVC.h"
#import "JQMyAlbumModel.h"
#import "NSObject+SQLService.h"

#import "JQ3DAlbumVC.h"
@interface MyAlbumViewController ()<JQMyAlbumViewDelegate,JQAddAlbumVCdelegate>

@property(nonatomic,strong)JQMyAlbumView *mainView;
@property(nonatomic,strong )NSMutableArray *PhotoArrM;
@end

@implementation MyAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    1.查看数据库有没有相册数据
    NSMutableArray *modelArr=[JQMyAlbumModel GetAllModelArrByTable];
    NSLog(@"%@",modelArr.firstObject);
    
//    2.有--显示  无--提醒用户添加相册
    if (modelArr.count==0) {
        //无
    }else
    {
        [self setUpMainView:modelArr];
    }
    
//    3.让用户新建一个相册

  
 
}

-(void)viewWillAppear:(BOOL)animated
{
    //最好做成通知有修改相册时在去刷新数据
    [self UpdateAlbumData];
}

-(void)UpdateAlbumData
{
     NSMutableArray *modelArr=[JQMyAlbumModel GetAllModelArrByTable];
    
    [self setUpMainView:modelArr];
}
-(void)CellClickWithIndex:(NSIndexPath *)indexPath withModel:(JQMyAlbumModel *)model
{

    //跳转相册
    JQ3DAlbumVC *vc=[[JQ3DAlbumVC alloc]init];
    vc.AlbumModel=model;
    [self.navigationController pushViewController:vc animated:YES];
    
    //    传图片数组
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    JQAddAlbumVC *vc=[[JQAddAlbumVC alloc]init];
    
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}


//初始化主视图
-(void)setUpMainView:(NSMutableArray*)dataArr
{
    
    [self.mainView configWithData:dataArr];
    [self.view addSubview:self.mainView];
    
}

-(JQMyAlbumView *)mainView
{
    if (_mainView==nil) {
        _mainView=[[JQMyAlbumView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _mainView.delegate=self;
    }
    return _mainView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
