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

@interface MyPageViewController ()<SimpleButtonsTableViewCellDelegate>

{
    NSMutableArray* datasource;
}

@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight=100;
    [self configureDataSource];
    // Do any additional setup after loading the view.
}

-(void)configureDataSource
{
    datasource=[NSMutableArray array];
    
    NSMutableArray* collections=[NSMutableArray array];
    [collections addObject:[[SimpleButtonModel alloc]initWithTitle:@"待付款" imageName:@"demo0" identifier:nil type:0 badge:1]];
    [collections addObject:[[SimpleButtonModel alloc]initWithTitle:@"待发货" imageName:@"demo0" identifier:nil type:0 badge:12]];
    [collections addObject:[[SimpleButtonModel alloc]initWithTitle:@"待收货" imageName:@"demo0" identifier:nil type:0 badge:144444]];
    [collections addObject:[[SimpleButtonModel alloc]initWithTitle:@"退换货" imageName:@"demo0" identifier:nil type:0 badge:10000000]];
    
    NSArray* sectionHeader=[NSArray arrayWithObjects:
                            [MyPageDataModel modelWithType:MyPageDataTypeHeader imageName:nil title:nil detail:nil badge:0 associateObject:nil],
                            [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"我的订单" detail:@"查看全部订单" badge:0 associateObject:nil],
                            [MyPageDataModel modelWithType:MyPageDataTypeCollection imageName:nil title:nil detail:nil badge:0 associateObject:collections],
                            nil];
    
    NSArray* sectionTokens=[NSArray arrayWithObjects:
                            [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"领取优惠券" detail:nil badge:10 associateObject:nil],
                            [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"我的优惠券" detail:nil badge:0 associateObject:nil], nil];
    
    NSArray* sectionScores=[NSArray arrayWithObjects:
                            [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"积分排行" detail:nil badge:10 associateObject:nil], nil];
    
    NSArray* sectionMines=[NSArray arrayWithObjects:
                            [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"我的购物车" detail:nil badge:10 associateObject:nil],
                            [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"我的关注" detail:nil badge:0 associateObject:nil],
                           [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"我的足迹" detail:nil badge:10 associateObject:nil],
                           [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"我的全返" detail:nil badge:10 associateObject:nil],nil];
    
    NSArray* sectionRecords=[NSArray arrayWithObjects:
                            [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"充值记录" detail:nil badge:10 associateObject:nil], nil];
    
    NSArray* sectionManagements=[NSArray arrayWithObjects:
                            [MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:nil title:@"收货地址管理" detail:nil badge:10 associateObject:nil], nil];
    
    [datasource addObject:sectionHeader];
    [datasource addObject:sectionTokens];
    [datasource addObject:sectionScores];
    [datasource addObject:sectionMines];
    [datasource addObject:sectionRecords];
    [datasource addObject:sectionManagements];
    [self.tableView reloadData];
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
    return datasource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* sectionArr=[datasource objectAtIndex:section];
    return sectionArr.count;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    
    NSArray* sectionArr=[datasource objectAtIndex:section];
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
        MyHeaderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyHeaderTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    
    //if nothing
    
    return [[UITableViewCell alloc]init];
}

@end
