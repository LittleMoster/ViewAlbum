//
//  DrawViewController.m
//  PhotoService
//
//  Created by cguo on 2017/10/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "DrawViewController.h"

#import "LXFDrawBoard.h"
#import "LXFRectangleBrush.h"
#import "LXFLineBrush.h"
#import "LXFArrowBrush.h"
#import "LXFTextBrush.h"
#import "LXFMosaicBrush.h"
#import "LXFEraserBrush.h"

@interface DrawViewController () <LXFDrawBoardDelegate>

/** board */
@property (strong, nonatomic) LXFDrawBoard *board;
@property(nonatomic,strong)NSArray *BtnNameArr;
/** 描述 */
@property(nonatomic, copy) NSString *desc;

@end

@implementation DrawViewController

-(LXFDrawBoard *)board
{
    if (_board==nil) {
        _board=[[LXFDrawBoard alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight-60)];
        _board.image=[UIImage imageNamed:@"LXFBG"];
        _board.delegate=self;
    }
    return _board;
}
-(NSArray *)BtnNameArr
{
    if (_BtnNameArr==nil) {
        _BtnNameArr=@[@"撤销",@"反撤销",@"铅笔",@"箭头",@"直线",@"箭头",@"矩形",@"马赛克",@"橡皮擦"];
    }
    return _BtnNameArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    //    self.board.brush = [LXFRectangleBrush new];
    //    self.board.brush = [LXFLineBrush new];
    //    self.board.brush = [LXFArrowBrush new];
    //    self.board.brush = [LXFTextBrush new];
    
    [self.view addSubview:self.board];
    

    for (int i=0; i<self.BtnNameArr.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(ScreenWidth/9*i, ScreenHeight-40, ScreenWidth/9, 40);
        btn.tag=i;
        btn.titleLabel.font=[UIFont systemFontOfSize:9.0];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:self.BtnNameArr[i] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self.view addSubview:btn];
        
    }
}

-(void)BtnClick:(UIButton*)btn
{
    switch (btn.tag) {
        case 0:
            [self.board revoke];
            break;
        case 1:
             [self.board redo];
            break;
        case 2:
            self.board.brush = [LXFPencilBrush share];
            self.board.style.lineWidth = 2;
            break;
        case 3:
            self.board.brush = [LXFArrowBrush new];
            self.board.style.lineWidth = 2;
            break;
        case 4:
            self.board.brush = [LXFLineBrush new];
            self.board.style.lineWidth = 2;

            break;
        case 5:
            self.board.brush = [LXFTextBrush new];
            self.board.style.lineWidth = 2;

            break;
        case 6:
            self.board.brush = [LXFRectangleBrush new];
            self.board.style.lineWidth = 2;

            break;
        case 7:
            self.board.brush = [LXFMosaicBrush new];
            self.board.style.lineWidth = 2;
            break;
        case 8:
            self.board.brush = [LXFEraserBrush new];
            // 调整笔刷大小
            self.board.style.lineWidth = 10;
            break;
            
        default:
            break;
    }
}

- (IBAction)lineBrush {
   }
- (IBAction)textBrush {
   }
- (IBAction)rectangleBrush {
   }
- (IBAction)mosaicBrush {
    
}
- (IBAction)eraserBrush {
    self.board.brush = [LXFEraserBrush new];
    // 调整笔刷大小
    self.board.style.lineWidth = 10;
    
}

#pragma mark - LXFDrawBoardDelegate
- (NSString *)LXFDrawBoard:(LXFDrawBoard *)drawBoard textForDescLabel:(UILabel *)descLabel {
    
    //    return [NSString stringWithFormat:@"我的随机数：%d", arc4random_uniform(256)];
    return self.desc;
}

- (void)LXFDrawBoard:(LXFDrawBoard *)drawBoard clickDescLabel:(UILabel *)descLabel {
    descLabel ? self.desc = descLabel.text: nil;
    [self alterDrawBoardDescLabel];
}

- (void)alterDrawBoardDescLabel {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加描述" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.desc = alertController.textFields.firstObject.text;
        [self.board alterDescLabel];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
        textField.text = self.desc;
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
