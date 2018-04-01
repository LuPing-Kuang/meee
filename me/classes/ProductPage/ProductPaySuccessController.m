//
//  ProductPaySuccessController.m
//  me
//
//  Created by 邝路平 on 2018/3/26.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductPaySuccessController.h"
#import "ProductOrderComfirmTableViewController.h"
#import "ProductOrderBillViewController.h"
#import "OrderDetailController.h"

@interface ProductPaySuccessController ()

@end

@implementation ProductPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付结果";
    [self setupSubViews];
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


- (void)naviBackAction {
    
    NSArray *Vcs = self.navigationController.viewControllers;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (NSInteger i=0; i<Vcs.count; i++) {
        UIViewController *vc = self.navigationController.viewControllers[i];
        if (![vc isKindOfClass:[ProductOrderComfirmTableViewController class]] && ![vc isKindOfClass:[ProductOrderBillViewController class]]) {
            [arr addObject:vc];
        }
    }
    
    self.navigationController.viewControllers = arr;
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)checkBillBtnClick:(UIButton *)sender {
    
    OrderDetailController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([OrderDetailController class])];
    vc.orderId = self.orderId;
    
    [self.navigationController pushViewController:vc animated:true];
    
    
    
}





@end
