//
//  MyOrderTableViewController.m
//  me
//
//  Created by jam on 2018/1/12.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOrderTableViewController.h"
#import "MyPageHttpTool.h"
#import "MyOrderListTableViewCell.h"

@interface MyOrderTableViewController ()

@end

@implementation MyOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.backgroundColor=_randomColor;
    
    UILabel * lab=[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100,30)];
    lab.text=self.title;
    lab.backgroundColor=[UIColor redColor];
    [self.tableView addSubview:lab];
    
    [self refresh];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    [self loadingDataRefreshing:YES];
}

-(void)loadMore
{
    [self loadingDataRefreshing:NO];
}

-(void)loadingDataRefreshing:(BOOL)refreshing
{
    NSInteger pagesize=30;
    NSInteger page=self.currentPage+1;
    if (refreshing) {
        page=1;
    }
    [MyPageHttpTool getMyOrdersCache:NO token:[UserModel token] status:self.orderType page:page pagesize:pagesize merchid:0 success:^(NSArray *result) {
        if(refreshing)
        {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:result];
        
        [self.tableView reloadData];
        
        if (result.count>0) {
            if (refreshing) {
                self.currentPage=1;
            }
            else
            {
                self.currentPage=self.currentPage+1;
            }
        }
        
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
}

#pragma mark tableviews

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyOrderModel* order=[self.dataSource objectAtIndex:section];
    NSInteger count=2+order.products.count;
    
    NSInteger status=order.status.integerValue;
    if (status==MyOrderTypeNotPaid||status==MyOrderTypeNotReceived||status==MyOrderTypeFinished) {
        count=count+1;
    }
    
    return count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    
    MyOrderModel* order=[self.dataSource objectAtIndex:section];
    NSInteger productCount=order.products.count;
    
    NSString* identifier=@"";
    if (row==0) {
        identifier=@"MyOrderListTitle";
    }
    else if(row-1<productCount)
    {
        identifier=@"MyOrderListGood";
    }
    else if(row-1==productCount)
    {
        identifier=@"MyOrderListPrice";
    }
    else
    {
        NSInteger status=order.status.integerValue;
        if (status==MyOrderTypeNotPaid)
        {
            identifier=@"MyOrderListNotPaidAction";
        }
        else if(status==MyOrderTypeNotReceived)
        {
            identifier=@"MyOrderListNotReceivedAction";
        }
        else if(status==MyOrderTypeFinished)
        {
            identifier=@"MyOrderListFinishedAction";
        }
    }
    
    if (identifier.length>0) {
        
        MyOrderListTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.tag=section;
        
        //header's
        cell.orderNumber.text=order.ordersn;
        cell.orderStatus.text=order.statusstr;
        
        //price's
        cell.orderTotalCount.text=[NSString stringWithFormat:@"%ld",(long)order.goods_num.integerValue];
        cell.orderTotalPrice.text=[NSString stringWithFloat:order.price.doubleValue headUnit:@"¥" tailUnit:nil];
        
        //goods'
        NSInteger realProductIndex=row-1;
        if (realProductIndex<productCount&&realProductIndex>=0) {
            MyOrderProductModel* pro=[order.products objectAtIndex:realProductIndex];
            [cell.productImage setImageUrl:pro.thumb];
            cell.productTitle.text=pro.title;
            cell.productOption.text=pro.optiontitle;
            cell.productPrice.text=[NSString stringWithFloat:pro.price.doubleValue headUnit:@"¥" tailUnit:nil];
            cell.productCount.text=[NSString stringWithFormat:@"x%ld",(long)pro.total.integerValue];
        }
        
        //actions
        [cell.orderButtonCancel addTarget:self action:@selector(orderCancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.orderButtonPay addTarget:self action:@selector(orderPayClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.orderButtonTransport addTarget:self action:@selector(orderTransportClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.orderButtonComfirm addTarget:self action:@selector(orderComfirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.orderButtonJudge addTarget:self action:@selector(orderJudgeClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.orderButtonDelete addTarget:self action:@selector(orderDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

#pragma mark order actions

-(MyOrderModel*)orderWithTagFromButton:(UIButton*)button
{
    NSInteger tag=button.tag;
    if (tag<self.dataSource.count) {
        return [self.dataSource objectAtIndex:tag];
    }
    return nil;
}

-(void)orderCancelClick:(UIButton*)button
{
    [self testButton:button];
}

-(void)orderPayClick:(UIButton*)button
{
    [self testButton:button];
}

-(void)orderTransportClick:(UIButton*)button
{
    [self testButton:button];
}

-(void)orderComfirmClick:(UIButton*)button
{
    [self testButton:button];
}

-(void)orderJudgeClick:(UIButton*)button
{
    [self testButton:button];
}

-(void)orderDeleteClick:(UIButton*)button
{
    [self testButton:button];
}

-(void)testButton:(UIButton*)button
{
    MyOrderModel* order=[self orderWithTagFromButton:button];
    
    NSString* msg=[button titleForState:UIControlStateNormal];
    NSString* testStr=[NSString stringWithFormat:@"%@\n%@",order.ordersn,msg];
    
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:testStr delegate:nil cancelButtonTitle:@"哦" otherButtonTitles:nil];
    [alert show];
}

@end
