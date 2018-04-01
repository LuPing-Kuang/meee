//
//  TransportViewController.m
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "TransportViewController.h"
#import "MyPageHttpTool.h"
#import "TransportViewCell.h"
#import "BundlelistMsgModel.h"
#import "TransportViewCell.h"
#import "MyOrderModel.h"
#import "TransportMsgViewController.h"
@interface TransportViewController ()
@property (nonatomic, strong)  NSArray *bundleModelArr;

@end

@implementation TransportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"包裹列表";
    
    [self refresh];
    
    
}



-(void)refresh
{
    [self loadingDataRefreshing:YES];
}



-(void)loadingDataRefreshing:(BOOL)refreshing
{
    
    MJWeakSelf;
    
    [MyPageHttpTool queryTransportWithOriderId:self.orderId WithSendtype:nil IsFotBundel:YES  withCompleted:^(id result, BOOL success) {
        if (success) {
            weakSelf.bundleModelArr = result;
            [weakSelf.tableView reloadData];
            [weakSelf endRefresh];
        }else{
            [weakSelf showErrorMsg:result];
            [weakSelf endRefresh];
        }
        
    }];
    
}

#pragma mark tableviews

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bundleModelArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TransportViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"TransportViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BundlelistMsgModel *bundleModel = self.bundleModelArr[indexPath.row];
    MyOrderProductModel *orderModel = bundleModel.productArr.firstObject;
    MJWeakSelf;
    cell.sureBlock = ^(MyOrderProductModel *model) {
        TransportMsgViewController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"TransportMsgViewController"];
        vc.orderId = weakSelf.orderId;
        vc.productModel = model;
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.productModel = orderModel;
    cell.countLb.text = [NSString stringWithFormat:@"%@件商品",orderModel.total];
    cell.packLb.text = [NSString stringWithFormat:@"包裹%@",orderModel.sendtype];
    cell.contentLb.text = orderModel.title;
    [cell.productImageV setImageUrl:orderModel.thumb];
    
    return cell;
    
}







@end
