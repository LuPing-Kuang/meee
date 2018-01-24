//
//  GetCashDetailController.m
//  me
//
//  Created by KLP on 2018/1/19.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "GetCashDetailController.h"
#import "GetCashDetailCell.h"
#import "MyPageHttpTool.h"

@interface GetCashDetailController ()

@end

@implementation GetCashDetailController

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
    [MyPageHttpTool getMyCashDetailCache:NO token:[UserModel token] status:self.detailType page:page pagesize:pagesize success:^(GetCashDetailTotalModel *model) {
        if(refreshing)
        {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:model.list];
        
        [self.tableView reloadData];
        
        if (model.list.count>0) {
            if (refreshing) {
                self.currentPage=1;
            }
            else
            {
                self.currentPage=self.currentPage+1;
            }
        }
    } failure:^(NSString *errorMsg) {
        [weakSelf showErrorMsg:errorMsg];
        [self.tableView reloadData];
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
    
    GetCashDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"GetCashDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
    
}



@end
