//
//  GetCashDetailPageController.m
//  me
//
//  Created by KLP on 2018/1/19.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "GetCashDetailPageController.h"
#import "GetCashDetailController.h"
#import "MyPageHttpTool.h"

@interface GetCashDetailPageController ()<ZZPagerControllerDataSource>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIView *titleContentV;

@property (nonatomic, strong) GetCashDetailTotalModel *model;


@end

@implementation GetCashDetailPageController

{
    BOOL jumpedCustomPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提现明细";
    self.menuNormalColor = [UIColor darkGrayColor];
    self.menuSelectedColor = _importantColor;
    self.dataSource=self;
    
    
    self.titleContentV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.titleContentV.backgroundColor=_importantColor;
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, self.titleContentV.bounds.size.width - 2*12, self.titleContentV.bounds.size.height)];
    self.titleLb.backgroundColor = [UIColor clearColor];
    self.titleLb.font = [UIFont systemFontOfSize:16];
    self.titleLb.textColor = [UIColor whiteColor];
    self.titleLb.text = @"预计佣金:+0.00元";
    
    [self.titleContentV addSubview:self.titleLb];
    
    [self.view addSubview:self.titleContentV];
    

    [self getTotalMoney];
}



- (void)getTotalMoney{
    MJWeakSelf;
    NSInteger pagesize=30;
    NSInteger page=1;
    [MyPageHttpTool getMyCashDetailCache:NO token:[UserModel token] status:GetCashDetailTypeAll page:page pagesize:pagesize success:^(GetCashDetailTotalModel *model) {
        weakSelf.model = model;
        weakSelf.titleLb.text = [NSString stringWithFormat:@"预计佣金:+%@元",weakSelf.model.commissioncount];
        
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
    return 5;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    return [GetCashDetailTotalModel titleForCashType:[GetCashDetailTotalModel cashTypeForPagerIndex:index]];
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    GetCashDetailController* orderVc=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"GetCashDetailController"];
    
    orderVc.title=self.titleArr[index];
    orderVc.detailType = [GetCashDetailTotalModel cashTypeForPagerIndex:index];
    
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
