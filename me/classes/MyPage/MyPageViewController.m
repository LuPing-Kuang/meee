//
//  MyPageViewController.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyPageViewController.h"

#import "MySimpleTableViewCell.h"
#import "MyHeaderTableViewCell.h"
#import "MyOrderCollectionTableViewCell.h"

#import "MyPageDataModel.h"

#import "MyPageHttpTool.h"

#import "MyOrdersPagerViewController.h"
#import "MyOrderTableViewController.h"

@interface MyPageViewController ()<SimpleButtonsTableViewCellDelegate>

@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"会员中心";
    
    self.tableView.estimatedRowHeight=100;
    [self loadDataFromLocal:YES];
    [self refresh];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    [self loadDataFromLocal:NO];
}

-(void)loadDataFromLocal:(BOOL)local
{
    [MyPageHttpTool getMyPageDataCache:NO token:[UserModel token] local:local success:^(NSArray *myPageSections) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:myPageSections];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
}

#pragma mark tableview datasource delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* sectionArr=[self.dataSource objectAtIndex:section];
    return sectionArr.count;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    
    NSArray* sectionArr=[self.dataSource objectAtIndex:section];
    MyPageDataModel* mo=[sectionArr objectAtIndex:row];
    
    if (mo.dataType==MyPageDataTypeNormal) {
        MySimpleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MySimpleTableViewCell" forIndexPath:indexPath];
        cell.image.image=[UIImage imageNamed:mo.imageName];
        cell.title.text=mo.title;
        cell.detail.text=mo.detail;
        cell.badge=mo.badge;
        return cell;
    }
    else if(mo.dataType==MyPageDataTypeCollection)
    {
        MyOrderCollectionTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyOrderCollectionTableViewCell" forIndexPath:indexPath];
        if (mo.associateObject) {
            [cell setButtons:mo.associateObject];
        }
        [cell setDelegate:self];
        return cell;
    }
    else if(mo.dataType==MyPageDataTypeHeader)
    {
        UserModel* us=mo.associateObject;
        MyHeaderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyHeaderTableViewCell" forIndexPath:indexPath];
        [cell.headImageView setImageUrl:us.avatar];
        cell.moneyLabel.text=us.money;
        cell.scoreLabel.text=[NSString stringWithFormat:@"%ld",(long)us.credit.integerValue];
        cell.nameLabel.text=us.nickname;
        cell.levelName.text=[NSString stringWithFormat:@"[%@]",us.levelname];
        if (us.levelname.length==0) {
            cell.levelName.text=nil;
        }

        [cell.topupButton addTarget:self action:@selector(goToTopUp) forControlEvents:UIControlEventTouchUpInside];
        [cell.settingButton addTarget:self action:@selector(goToSetting) forControlEvents:UIControlEventTouchUpInside];
        [cell.headButton addTarget:self action:@selector(goToChangeAvatar) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    //if nothing
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray* sectionArr=[self.dataSource objectAtIndex:indexPath.section];
    MyPageDataModel* mo=[sectionArr objectAtIndex:indexPath.row];

    NSString* link=mo.action;
    
    if ([link isEqualToString:@"member.address"]) {
        [self pushViewControllerForStoryBoardId:@"MyAddressesTableViewController"];
    }
    else if([link isEqualToString:@"member.history"])
    {
        [self pushViewControllerForStoryBoardId:@"MyFootPrintTableViewController"];
    }
    else if([link isEqualToString:@"member.favorite"])
    {
        
    }
    else if([link isEqualToString:@"member.cart"])
    {
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CartPageViewController"] animated:YES];
    }
    else if([link isEqualToString:@"order"])
    {
        [self pushOrderViewControllerWithShowingOrderType:MyOrderTypeAll];
    }
}

#pragma mark SimpleButtonsTableViewCellDelegate

-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell *)cell didSelectedModel:(SimpleButtonModel *)model
{
    NSString* link=model.identifier;
    NSInteger type=model.type;
    if ([link isEqualToString:@"order"]) {
        if (type==MyOrderTypeExchanging) {
            MyOrderTableViewController* exOrderVC=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyOrderTableViewController"];
            MyOrderType orderType=type;
            exOrderVC.title=[MyOrderModel titleForOrderType:orderType];
            exOrderVC.orderType=orderType;
            [self.navigationController pushViewController:exOrderVC animated:YES];
            return;
        }
        [self pushOrderViewControllerWithShowingOrderType:type];
    }
}

#pragma mark actions

-(void)pushViewControllerForStoryBoardId:(NSString*)ident
{
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:ident] animated:YES];
}

-(void)pushOrderViewControllerWithShowingOrderType:(MyOrderType)showingType
{
    MyOrdersPagerViewController* pag=[[MyOrdersPagerViewController alloc]init];
    pag.originalPageIndex=[MyOrderModel pageIndexForOrderType:showingType];
    [self.navigationController pushViewController:pag animated:YES];
}

-(void)goToSetting
{
    NSLog(@"setting");
}

-(void)goToTopUp
{
    NSLog(@"topup");
}

-(void)goToChangeAvatar
{
    NSLog(@"avatar");
    UIViewController* log=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:log animated:YES completion:nil];
}

@end
