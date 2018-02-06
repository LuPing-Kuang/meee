//
//  ReportNewsController.m
//  me
//
//  Created by KLP on 2018/1/29.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ReportNewsController.h"
#import "ReportNewsCell.h"
#import "ReportNewsModel.h"
#import "UserDataLoader.h"

@interface ReportNewsController ()

@end

@implementation ReportNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"商城公告";
    
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
    
    [UserDataLoader getMyReportNewsPage:page pagesize:pagesize withCompleted:^(NSArray *result, BOOL success) {
        if (success) {
            
            if(refreshing)
            {
                [weakSelf.dataSource removeAllObjects];
            }
            
            [weakSelf.dataSource addObjectsFromArray:result];
            
            [weakSelf.tableView reloadData];
            [weakSelf endRefresh];
            if (result.count>0) {
                if (refreshing) {
                    weakSelf.currentPage=1;
                }
                else
                {
                    weakSelf.currentPage=weakSelf.currentPage+1;
                }
            }
            
        }else{
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
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReportNewsCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ReportNewsCell" forIndexPath:indexPath];
    cell.reportModel = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportNewsModel *model = self.dataSource[indexPath.row];
    
    BaseWebViewController *vc = [[BaseWebViewController alloc]initWithHtml:model.detail];
    vc.title = @"公告详情";
    [self.navigationController pushViewController:vc animated:YES];
}





@end
