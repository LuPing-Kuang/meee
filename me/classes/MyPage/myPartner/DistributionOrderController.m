//
//  DistributionOrderController.m
//  me
//
//  Created by KLP on 2018/1/19.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "DistributionOrderController.h"
#import "DistributionOrderCell.h"
#import "MyPageHttpTool.h"

@interface DistributionOrderController ()

@end

@implementation DistributionOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [MyPageHttpTool getMyDistributionOrderCache:NO token:[UserModel token] status:self.distributionType page:page pagesize:pagesize success:^(DistributionTotalOrderModel *model) {
        if(refreshing)
        {
            [weakSelf.dataSource removeAllObjects];
        }
        
        [weakSelf.dataSource addObjectsFromArray:model.list];
        
        [weakSelf.tableView reloadData];
        [weakSelf endRefresh];
        if (model.list.count>0) {
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
    
    DistributionOrderModel *list = (DistributionOrderModel*)self.dataSource[section];
    
    return list.order_goods.count + 2;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DistributionOrderModel *list = (DistributionOrderModel*)self.dataSource[indexPath.section];
    if (indexPath.row == 0) {
        DistributionOrderCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionOrderHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headerModel = list.buyer;
        
        return cell;
    }else if (indexPath.row == list.order_goods.count + 2 - 1){
        DistributionOrderCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionOrderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = list;
        
        return cell;
    }else{
        DistributionOrderCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionOrderGoodsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goodsModel = list.order_goods[indexPath.row - 1];
        
        return cell;
    }
    
}


@end
