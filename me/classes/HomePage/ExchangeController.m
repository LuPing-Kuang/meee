//
//  ExchangeController.m
//  me
//
//  Created by 邝路平 on 2018/3/14.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ExchangeController.h"
#import "HomePageHttpTool.h"
#import "ExchangeResultView.h"
#import "ExchangeMsgView.h"
#import "exchangeModel.h"
#import "QRCodeScanningController.h"

@interface ExchangeController ()

@property (nonatomic,strong) ExchangeResultView *resultView;
@property (nonatomic,strong) ExchangeMsgView *msgView;

@property (nonatomic,strong) exchangeModel *model;

@property (nonatomic,assign) CGRect rect;

@end

@implementation ExchangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupSubViews];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    self.rect = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
}


- (void)setupSubViews {
    UIImage *leftButtonImg = [UIImage imageNamed:@"back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:leftButtonImg forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0,0,44,44);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 44-leftButtonImg.size.width);
    [backBtn addTarget:self action:@selector(naviBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *naviBack = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = naviBack;
}

- (void)naviBackAction{
    
    NSArray *Vcs = self.navigationController.viewControllers;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (NSInteger i=0; i<Vcs.count; i++) {
        UIViewController *vc = self.navigationController.viewControllers[i];
        if (![vc isKindOfClass:[QRCodeScanningController class]] && ![vc isKindOfClass:[ExchangeController class]]) {
            [arr addObject:vc];
        }
    }
    
    self.navigationController.viewControllers = arr;
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithTitle:(NSString *)title{
    
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    if (self) {
        
        self.title = title;
    }
    return self;
}


- (void)loadData {
    MJWeakSelf;
    [HUDManager showLoading:@"查询中"];
    [HomePageHttpTool exchangeNumMsg:self.key WithCompleted:^(id result, BOOL success) {
        [HUDManager dismiss];
        if (success) {
            if ([result isKindOfClass:[NSArray class]]) {
                
                NSArray *arr = (NSArray *)result;
                if (arr.count>0) {
                    weakSelf.model = [exchangeModel mj_objectWithKeyValues:arr
                                      .firstObject];
                }
            }else if ([result isKindOfClass:[NSString class]]){
                [HUDManager showErrorMsg:@"你的账号无法兑换，请登陆！"];
            }else{
                [HUDManager showErrorMsg:BadNetworkDescription];
            }
            
            
        }else{
            
            NSString *str = (NSString*)result;
            if ([str isEqualToString:@"兑换码已兑换"]) {
                [HUDManager showErrorMsg:@"兑换码已兑换"];
            }else{
                weakSelf.resultView.frame = weakSelf.rect;
                [weakSelf.view addSubview:weakSelf.resultView];
                [weakSelf.resultView showError];
            }
            
        }
    }];
}



- (void)exchangeMoney {
    MJWeakSelf;
    [HUDManager showLoading:@"兑换中"];
    [HomePageHttpTool exchangeMoney:self.model.key WithCompleted:^(id result, BOOL success) {
        [HUDManager dismiss];
        if (success) {
            [HUDManager showSuccessMsg:@"兑换成功"];
            weakSelf.resultView.frame = weakSelf.rect;
            [weakSelf.view addSubview:weakSelf.resultView];
            [weakSelf.resultView showSuccess];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];
}

- (void)setModel:(exchangeModel *)model{
    _model = model;
    self.msgView.frame = self.rect;
    self.msgView.model = _model;
    [self.view addSubview:self.msgView];
    
    
}

#pragma mark -
#pragma mark - 懒加载
- (ExchangeResultView *)resultView{
    if (_resultView == nil) {
        MJWeakSelf;
        _resultView = LOAD_XIB_CLASS(ExchangeResultView);
        _resultView.sureBlock = ^(BOOL success) {
            if (success) {
                [weakSelf naviBackAction];
            }else{
                [weakSelf scanAgain];
            }
        };
    }
    return _resultView;
}

- (ExchangeMsgView *)msgView{
    if (_msgView == nil) {
        _msgView = LOAD_XIB_CLASS(ExchangeMsgView);
        MJWeakSelf;
        _msgView.exchangeBlock = ^{
            [weakSelf exchangeMoney];
        };
        
        _msgView.backBlock = ^{
            [weakSelf naviBackAction];
        };
    }
    return _msgView;
}


- (void)scanAgain {
    
    QRCodeScanningController *vc = [[QRCodeScanningController alloc]init];
    vc.title = @"扫一扫";
    vc.hidesBottomBarWhenPushed = YES;
    MJWeakSelf;
    vc.ScanBlock = ^(NSString *str, BOOL success) {
        if (success) {
            ExchangeController *vc = [[ExchangeController alloc]initWithTitle:@"兑换中心"];
            vc.key = str;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}





@end
