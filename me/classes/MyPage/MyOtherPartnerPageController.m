//
//  MyOtherPartnerPageController.m
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOtherPartnerPageController.h"
#import "MyOtherPartnerController.h"
@interface MyOtherPartnerPageController ()<ZZPagerControllerDataSource>
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIView *titleContentV;
@end

@implementation MyOtherPartnerPageController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuNormalColor = [UIColor darkGrayColor];
    self.menuSelectedColor = _importantColor;
    self.dataSource=self;
    
    
    
}





#pragma mark ZZPageerDatasource

-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController *)pager
{
    return 3.0;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    return [MyOtherPartnerTotalModel titleForLevelType:[MyOtherPartnerTotalModel levelTypeForPagerIndex:index]];
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    MyOtherPartnerController* orderVc=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyOtherPartnerController"];
    
    orderVc.title=self.titleArr[index];
    orderVc.levelType = [MyOtherPartnerTotalModel levelTypeForPagerIndex:index];
    
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
