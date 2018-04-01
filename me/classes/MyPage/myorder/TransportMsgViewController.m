//
//  TransportMsgViewController.m
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "TransportMsgViewController.h"
#import "MyPageHttpTool.h"
#import "TransportMsgCell.h"
#import "TransportMsgModel.h"

@interface TransportMsgViewController ()
@property (nonatomic, strong) TransportMsgModel *trantModel;


@end

@implementation TransportMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"物流信息";
    
    [self refresh];
    
    
}



-(void)refresh
{
    [self loadingDataRefreshing:YES];
}



-(void)loadingDataRefreshing:(BOOL)refreshing
{
   
    MJWeakSelf;
    
    [MyPageHttpTool queryTransportWithOriderId:self.orderId WithSendtype:[NSString stringWithFormat:@"%@",self.productModel.sendtype] IsFotBundel:NO withCompleted:^(id result, BOOL success) {
        if (success) {
            weakSelf.trantModel = result;
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
    return 1 + self.trantModel.expresslist.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        TransportMsgCell* cell=[tableView dequeueReusableCellWithIdentifier:@"TransportMsgHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MyOrderProductModel *orderModel = self.trantModel.productArr.firstObject;
        cell.expressStatusLb.text = self.trantModel.statusstr;
        cell.transportCompanyLb.text = self.trantModel.express;
        cell.orderNumLb.text = self.trantModel.expresssn;
        [cell.productImageV setImageUrl:orderModel.thumb];
        cell.productNameLb.text = orderModel.title;
        cell.productCountLb.text = [NSString stringWithFormat:@"%@件商品",orderModel.total];
        return cell;
    }else{
        TransportMsgCell* cell=[tableView dequeueReusableCellWithIdentifier:@"TransportMsgCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TransportMsgListModel *addressModel = self.trantModel.expresslist[indexPath.row-1];
        cell.addressLb.text = addressModel.step;
        cell.timeLb.text = addressModel.time;
        if (indexPath.row==1) {
            cell.addressLb.textColor = _redColor;
            cell.timeLb.textColor = _redColor;
            cell.dotV.backgroundColor = _redColor;
            
        }else{
            cell.addressLb.textColor = [UIColor darkGrayColor];
            cell.timeLb.textColor = [UIColor darkGrayColor];
            cell.dotV.backgroundColor = RGB(183, 183, 183);
        }
        return cell;
    }
    
    
    return [[UITableViewCell alloc]init];
    
}







@end
