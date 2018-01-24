//
//  DistributionOrderPageController.m
//  me
//
//  Created by KLP on 2018/1/19.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "DistributionOrderPageController.h"
#import "DistributionOrderController.h"
#import "MyPageHttpTool.h"


@interface DistributionOrderPageController ()<ZZPagerControllerDataSource>

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIView *titleContentV;
@property (nonatomic, strong) DistributionTotalOrderModel *model;


@end

@implementation DistributionOrderPageController

{
    BOOL jumpedCustomPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"分销订单";
    self.menuNormalColor = [UIColor darkGrayColor];
    self.menuSelectedColor = _importantColor;
    self.dataSource=self;
    
    
    self.titleContentV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.titleContentV.backgroundColor=_importantColor;
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, self.titleContentV.bounds.size.width - 2*12, self.titleContentV.bounds.size.height)];
    self.titleLb.backgroundColor = [UIColor clearColor];
    self.titleLb.font = [UIFont systemFontOfSize:16];
    self.titleLb.textColor = [UIColor whiteColor];
    self.titleLb.text = @"累计佣金:+0.00元";
    
    [self.titleContentV addSubview:self.titleLb];
    
    [self.view addSubview:self.titleContentV];
    
    [self getTotalMoney];
}


- (void)getTotalMoney{
    MJWeakSelf;
    NSInteger pagesize=30;
    NSInteger page=1;
    [MyPageHttpTool getMyDistributionOrderCache:NO token:[UserModel token] status:DistributionOrderTypeAll page:page pagesize:pagesize success:^(DistributionTotalOrderModel *model) {
        weakSelf.model = model;
        weakSelf.titleLb.text = [NSString stringWithFormat:@"累计佣金:+%@元",weakSelf.model.comtotal];
    } failure:^(NSString *errorMsg) {
        
    }];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!jumpedCustomPage) {
        self.selectedPage=self.originalPageIndex;
    }
    jumpedCustomPage=YES;
}


#pragma mark ZZPageerDatasource

-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController *)pager
{
    return 4;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    return [DistributionTotalOrderModel titleForOrderType:[DistributionTotalOrderModel orderTypeForPagerIndex:index]];
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    DistributionOrderController* orderVc=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"DistributionOrderController"];
    
    orderVc.title=[DistributionTotalOrderModel titleForOrderType:[DistributionTotalOrderModel orderTypeForPagerIndex:index]];
    orderVc.distributionType = [DistributionTotalOrderModel orderTypeForPagerIndex:index];
    
    return orderVc;
}

-(CGRect)pagerController:(ZZPagerController *)pager frameForMenuView:(ZZPagerMenu *)menu
{
    return CGRectMake(0, 40, self.view.frame.size.width, 40);
}

-(CGRect)pagerController:(ZZPagerController *)pager frameForContentView:(UIScrollView *)scrollView
{
    CGRect menuR=[self pagerController:pager frameForMenuView:nil];
    CGFloat menuMy=CGRectGetMaxY(menuR);
    return CGRectMake(0, menuMy, self.view.frame.size.width, self.view.frame.size.height-menuMy-ZZPagerDefaultStatusBarHeight-ZZPagerDefaultNavigationBarHeight);
}

@end
