//
//  GetCashRealDetailController.m
//  me
//
//  Created by HeYang on 2018/5/2.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "GetCashRealDetailController.h"
#import "GetCashRealDetailModel.h"
#import "MyPageHttpTool.h"
#import "GetCashRealDetailCell.h"

@interface GetCashRealDetailController ()

@end

@implementation GetCashRealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"详情";
    [self refresh];
    [self showLoadMoreView];
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
    MJWeakSelf;
    [MyPageHttpTool getMyCashDetail:self.orderId page:page pagesize:pagesize success:^(NSArray<GetCashRealDetailModel*> *arr) {
        if(refreshing)
        {
            [weakSelf.dataSource removeAllObjects];
        }
        
        [weakSelf.dataSource addObjectsFromArray:arr];
        
        [weakSelf.tableView reloadData];
        [weakSelf endRefresh];
        if (arr.count>0) {
            if (refreshing) {
                weakSelf.currentPage=1;
            }
            else
            {
                weakSelf.currentPage=weakSelf.currentPage+1;
            }
        }
    } failure:^(NSString *errorMsg) {
        [weakSelf showErrorMsg:errorMsg];
        [weakSelf endRefresh];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    GetCashRealDetailModel *model = self.dataSource[section];
    
    return model.goods.count + 2;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GetCashRealDetailModel *model = self.dataSource[indexPath.section];
    if (indexPath.row == 0) {
        GetCashRealDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"GetCashRealDetailHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ordercommissionLb.text = [NSString stringWithFormat:@"%@元",model.ordercommission];
        cell.orderpayLb.text = [NSString stringWithFormat:@"%@元",model.orderpay];
        
        return cell;
        
    }else if (indexPath.row == (model.goods.count + 1)) {
        GetCashRealDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"GetCashRealDetailFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderNumLb.text = model.ordersn;
        cell.orderPriceLb.text = [NSString stringWithFormat:@"%@元",model.goodsprice];
        
        return cell;
        
    }else {GetCashRealDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"GetCashRealDetailGoodsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetCashRealDetailGoodModel *goodsM = model.goods[indexPath.row - 1];
        [cell.goodsImageV setImageUrl:goodsM.thumb];
        cell.goodsNameLb.text = goodsM.title;
        cell.commissionLb.text = [NSString stringWithFormat:@"%@元",goodsM.commission];
        cell.leveLb.text = [NSString stringWithFormat:@"%@级",goodsM.level];
        
        return cell;
    }
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}












@end
