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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DistributionOrderCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionOrderCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
    
}


@end
