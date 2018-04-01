//
//  MyOtherPartnerController.m
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOtherPartnerController.h"
#import "MyPageHttpTool.h"
#import "MyOtherPartnerCell.h"

@interface MyOtherPartnerController ()

@end

@implementation MyOtherPartnerController

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
    [MyPageHttpTool getMyOtherPartnerCache:NO token:[UserModel token] level:self.levelType page:page pagesize:pagesize success:^(MyOtherPartnerTotalModel *model) {
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
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 1.0;
    }else{
        return self.dataSource.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        MyOtherPartnerCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyOtherPartnerHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==1){
        MyOtherPartnerCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyOtherPartnerCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataSource[indexPath.row];
        return cell;
    }else{
        return [[UITableViewCell alloc]init];
    }
    
    
}


@end
