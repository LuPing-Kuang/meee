//
//  MyOrdersPagerViewController.m
//  me
//
//  Created by jam on 2018/1/12.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOrdersPagerViewController.h"

#import "MyOrderTableViewController.h"



@interface MyOrdersPagerViewController ()<ZZPagerControllerDataSource>

@end

@implementation MyOrdersPagerViewController
{
    BOOL jumpedCustomPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的订单";
    self.dataSource=self;
    
    UIBarButtonItem* trash=[[UIBarButtonItem alloc]initWithTitle:@"回收站" style:UIBarButtonItemStylePlain target:self action:@selector(goToTrashBin)];
    self.navigationItem.rightBarButtonItem=trash;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!jumpedCustomPage) {
        self.selectedPage=self.originalPageIndex;
    }
    jumpedCustomPage=YES;
}

-(void)goToTrashBin
{
    MyOrderTableViewController* exOrderVC=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyOrderTableViewController"];
    MyOrderType orderType=MyOrderTypeDeleted;
    exOrderVC.title=[MyOrderModel titleForOrderType:orderType];
    exOrderVC.orderType=orderType;
    [self.navigationController pushViewController:exOrderVC animated:YES];
}

#pragma mark ZZPageerDatasource

-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController *)pager
{
    return 5;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    return [MyOrderModel titleForOrderType:[MyOrderModel orderTypeForPagerIndex:index]];
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    MyOrderTableViewController* orderVc=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyOrderTableViewController"];
    MyOrderType orderType=[MyOrderModel orderTypeForPagerIndex:index];
    orderVc.title=[MyOrderModel titleForOrderType:orderType];
    orderVc.orderType=orderType;
    return orderVc;
}

-(CGRect)pagerController:(ZZPagerController *)pager frameForMenuView:(ZZPagerMenu *)menu
{
    return CGRectMake(0, 0, self.view.frame.size.width, 40);
}

-(CGRect)pagerController:(ZZPagerController *)pager frameForContentView:(UIScrollView *)scrollView
{
    CGRect menuR=[self pagerController:pager frameForMenuView:nil];
    CGFloat menuMy=CGRectGetMaxY(menuR);
    return CGRectMake(0, menuMy, self.view.frame.size.width, self.view.frame.size.height-menuMy-ZZPagerDefaultStatusBarHeight-ZZPagerDefaultNavigationBarHeight);
}

@end
