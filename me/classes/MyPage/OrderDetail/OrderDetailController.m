//
//  OrderDetailController.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailCell.h"
#import "MyPageHttpTool.h"
#import "MyOrderDetailModel.h"
#import "ProductionOrderModel.h"
#import "MyOrderDetailBottomView.h"
#import "ApplyRefundController.h"
#import "RefundProgressController.h"

@interface OrderDetailController ()
@property (nonatomic,strong) MyOrderDetailModel *detailModel;
@property (nonatomic,assign) BOOL ishasData;


@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self refresh];
    [self setBottomBarHidden:true];
}


- (void)setupBottomViews:(NSArray*)titleArr{
    
    MyOrderDetailBottomView *v = LOAD_XIB_CLASS(MyOrderDetailBottomView);
    CGRect fra=[self bottomFrame];
    v.frame = fra;
    v.titleArr = titleArr;
    MJWeakSelf;
    v.selectBlock = ^(NSInteger index) {
        if (weakSelf.detailModel.order.statusType == MyOrderStatusType_WaitSend && weakSelf.detailModel.order.canrefund && [weakSelf.detailModel.order.refundstate isEqualToString:@"0"]) {
            //申请退款
            [self applyToRefund:self.detailModel.order.ID];
            
        }else if (_detailModel.order.statusType == MyOrderStatusType_WaitSend && _detailModel.order.canrefund && ![_detailModel.order.refundstate isEqualToString:@"0"]) {
            //@"取消申请",@"查看申请退款进度"
            if (index == 0) {
                [weakSelf cancelapplyToRefund:weakSelf.orderId];
            }else {
                [weakSelf checkRefundProgress:weakSelf.orderId];
            }
            
        }else if (weakSelf.detailModel.order.statusType == MyOrderStatusType_Refund) {
            //@"取消申请",@"查看申请退款进度"
            if (index == 0) {
                [weakSelf cancelapplyToRefund:weakSelf.orderId];
            }else {
                [weakSelf checkRefundProgress:weakSelf.orderId];
            }
            
        }else if (weakSelf.detailModel.order.statusType == MyOrderStatusType_WaitPay) {
            //取消订单
            [weakSelf cancelOrder:weakSelf.detailModel.order.ID];
            
        }else if (weakSelf.detailModel.order.statusType == MyOrderStatusType_WaitGet) {
            //确认收货
            [weakSelf ConfirmOrder:weakSelf.detailModel.order.ID];
            
        }else if (weakSelf.detailModel.order.statusType == MyOrderStatusType_Finish) {
            //删除订单
            [weakSelf deleteOrder:weakSelf.detailModel.order.ID DeleteId:@"1"];
            
        }else if (weakSelf.detailModel.order.statusType == MyOrderStatusType_Delete) {
            //@[@"恢复订单",@"彻底删除订单"];
            if (index == 0) {
                [weakSelf deleteOrder:weakSelf.detailModel.order.ID DeleteId:@"0"];
            }else {
                [weakSelf deleteOrder:weakSelf.detailModel.order.ID DeleteId:@"2"];
            }
            
        }
        
    };
    [self setBottomSubView:v];
    [self setBottomBarHidden:false];

}



-(void)refresh
{
    [self loadingDataRefreshing:YES];
}


-(void)loadingDataRefreshing:(BOOL)refreshing
{
    MJWeakSelf;
    [MyPageHttpTool getOrderDetailId:self.orderId withCompleted:^(id result, BOOL success) {
        if (success) {
            weakSelf.detailModel = [MyOrderDetailModel mj_objectWithKeyValues:result];
            weakSelf.ishasData = true;
            [weakSelf.tableView reloadData];
            [weakSelf endRefresh];
        }else{
            [HUDManager showErrorMsg:result];
            weakSelf.ishasData = false;
            [weakSelf endRefresh];
        }
    }];
    
}

- (void)setDetailModel:(MyOrderDetailModel *)detailModel{
    _detailModel = detailModel;
    NSArray *titleArr = nil;
    if (_detailModel.order.statusType == MyOrderStatusType_WaitSend && _detailModel.order.canrefund && [_detailModel.order.refundstate isEqualToString:@"0"]) {
        titleArr = @[@"申请退款"];
    }else if (_detailModel.order.statusType == MyOrderStatusType_WaitSend && _detailModel.order.canrefund && ![_detailModel.order.refundstate isEqualToString:@"0"]) {
        titleArr = @[@"取消申请",@"查看申请退款进度"];
    }else if (_detailModel.order.statusType == MyOrderStatusType_Refund) {
        titleArr = @[@"取消申请",@"查看申请退款进度"];
    }else if (_detailModel.order.statusType == MyOrderStatusType_WaitPay) {
        titleArr = @[@"取消订单"];
    }else if (_detailModel.order.statusType == MyOrderStatusType_WaitGet) {
        titleArr = @[@"确认收货"];
    }else if (_detailModel.order.statusType == MyOrderStatusType_Finish) {
        titleArr = @[@"删除订单"];
    }else if (_detailModel.order.statusType == MyOrderStatusType_Delete) {
        titleArr = @[@"恢复订单",@"彻底删除订单"];
    }
    
    [self setupBottomViews:titleArr];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}


#pragma mark -
#pragma mark - tableViewDelegate、tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.ishasData) {
        return 5;
    }else{
        return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return self.detailModel.goods.count;
    }else {
        return 1;
    }

}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_detailModel.order.statusType == MyOrderStatusType_WaitSend && _detailModel.order.canrefund && [_detailModel.order.refundstate isEqualToString:@"1"]) {

           cell.statusLb.text = self.detailModel.order.refundtext;
            
        }else if (_detailModel.order.statusType == MyOrderStatusType_Refund) {
            cell.statusLb.text = self.detailModel.order.refundtext;
        }else {
            cell.statusLb.text = self.detailModel.order.statusstr;
        }
        
        
        cell.orderMoneyLb.text = [NSString stringWithFormat:@"订单金额:¥%@",self.detailModel.order.price];
        return cell;
    }else if (indexPath.section == 1) {
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailAddressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ProductionOrderAddressModel *ad = self.detailModel.address;
        cell.namePhoneLb.text = [NSString stringWithFormat:@"%@  %@",ad.realname,ad.mobile];
        cell.addressLb.text = [NSString stringWithFormat:@"%@%@%@%@%@",ad.province,ad.city,ad.area,ad.street,ad.address];
        return cell;
    }else if (indexPath.section == 2) {
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailProductCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        OrderGoodDetailModel *good = self.detailModel.goods[indexPath.row];
        [cell.productImageV setImageUrl:good.thumb];
        cell.productMoneyLb.text = [NSString stringWithFormat:@"¥%@",good.price];
        cell.productNumLb.text = [NSString stringWithFormat:@"x%@",good.total];
        cell.productNameLb.text = good.title;
        cell.productOptionLb.text = good.optionname;
        
        return cell;
    }else if (indexPath.section == 3) {
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailMoneyCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goodspriceLb.text = [NSString stringWithFormat:@"¥%@",self.detailModel.order.goodsprice];
        cell.dispatchpriceLb.text = [NSString stringWithFormat:@"¥%@",self.detailModel.order.dispatchprice];
        cell.TotalPriceLb.text = [NSString stringWithFormat:@"¥%@",self.detailModel.order.price];
        
        return cell;
    }else {
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderNumLb.text = self.detailModel.order.ordersn;
        cell.createTimeLb.text = [NSString stringWithFormat:@"创建时间 %@",self.detailModel.order.createtime];
        cell.payTimeLb.text = [NSString stringWithFormat:@"支付时间 %@",self.detailModel.order.paytime];
        cell.deliveryTimeLb.text = [NSString stringWithFormat:@"发货时间 %@",self.detailModel.order.sendtime];
        cell.finishTimeLb.text = [NSString stringWithFormat:@"完成时间 %@",self.detailModel.order.finishtime];
        
        if (self.detailModel.order.statusType == MyOrderStatusType_WaitPay) {
            cell.payTimeLb.hidden = true;
            cell.deliveryTimeLb.hidden = true;
            cell.finishTimeLb.hidden = true;
        }else if (self.detailModel.order.statusType == MyOrderStatusType_WaitSend) {
            cell.deliveryTimeLb.hidden = true;
            cell.finishTimeLb.hidden = true;
        }else if (self.detailModel.order.statusType == MyOrderStatusType_WaitGet) {
            cell.finishTimeLb.hidden = true;
        }
        
        
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 95;
        
    }else if (indexPath.section == 1) {
        return UITableViewAutomaticDimension;
        
    }else if (indexPath.section == 2) {
        return 200;
        
    }else if (indexPath.section == 3) {
        return 120;
        
    }else {
        if (self.detailModel.order.statusType == MyOrderStatusType_WaitPay) {
            return 27 * 2;
        }else if (self.detailModel.order.statusType == MyOrderStatusType_WaitSend) {
            return 27 * 3;
        }else if (self.detailModel.order.statusType == MyOrderStatusType_WaitGet) {
            return 27 * 4;
        }else{
            return 27 * 5;
        }
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}



#pragma mark -
#pragma mark - 一系列订单的操作
//取消订单
- (void)cancelOrder:(NSString*)orderId {
    MJWeakSelf;
    [self showSystemAlertWithTitle:@"提醒" message:@"确认要取消订单吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
        
    } btnBlock:^(UIAlertAction *action) {
        
        [self showLoading:@"正在取消中..."];
        [MyPageHttpTool cancelOrderId:orderId withCompleted:^(id result, BOOL success) {
            if (success) {
                
                if (weakSelf.needRefreshBlock) {
                    weakSelf.needRefreshBlock();
                }
                [weakSelf showSuccessMsg:@"成功取消订单"];
                [weakSelf.navigationController popViewControllerAnimated:true];
            }else{
                [weakSelf showErrorMsg:result];
            }
        }];
    }];
    

}

//删除订单 恢复订单
/*
 DeleteId 1删除，0恢复(只能恢复已完成订单),2(彻底删除订单)
 */
- (void)deleteOrder:(NSString*)orderId DeleteId:(NSString*)deleteId {
    MJWeakSelf;
    [self showSystemAlertWithTitle:@"提醒" message:@"确认要删除订单吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
        
    } btnBlock:^(UIAlertAction *action) {
        
        [self showLoading:@"删除订单中..."];
        
        
        [MyPageHttpTool deleteOrderId:orderId WithUserdeleted:deleteId withCompleted:^(id result, BOOL success) {
            if (success) {
                
                if (weakSelf.needRefreshBlock) {
                    weakSelf.needRefreshBlock();
                }
                [weakSelf showSuccessMsg:@"删除成功"];
                [weakSelf.navigationController popViewControllerAnimated:true];
                
            }else{
                [weakSelf showErrorMsg:result];
            }
        }];
    }];
    

}



//取消申请退款
- (void)cancelapplyToRefund:(NSString*)orderId {
    
    MJWeakSelf;
    [self showSystemAlertWithTitle:@"提醒" message:@"确认取消申请退款吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
        
    } btnBlock:^(UIAlertAction *action) {
        
        [self showLoading:@"取消申请中..."];
        
        [MyPageHttpTool cancelRefundApply:orderId withCompleted:^(id result, BOOL success) {
            if (success) {
                
                if (weakSelf.needRefreshBlock) {
                    weakSelf.needRefreshBlock();
                }
                [weakSelf showSuccessMsg:@"成功取消"];
                [weakSelf.navigationController popViewControllerAnimated:true];
                
            }else{
                [weakSelf showErrorMsg:result];
            }
        }];
        
    }];
    
}

//申请退款
- (void)applyToRefund:(NSString*)orderId {
    ApplyRefundController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([ApplyRefundController class])];
    vc.orderId = self.orderId;
    MJWeakSelf;
    vc.needRefreshBlock = ^{
        [weakSelf refresh];
    };
    
    [self.navigationController pushViewController:vc animated:true];
}


- (void)checkRefundProgress:(NSString*)orderId {
    
    RefundProgressController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([RefundProgressController class])];
    vc.orderId = self.orderId;
    MJWeakSelf;
    vc.needRefreshBlock = ^{
        [weakSelf refresh];
    };
    
    [self.navigationController pushViewController:vc animated:true];
}


//确认收货
- (void)ConfirmOrder:(NSString*)orderId {
    MJWeakSelf;
    
    [self showSystemAlertWithTitle:@"提醒" message:@"确认收货吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
        
    } btnBlock:^(UIAlertAction *action) {
        [self showLoading:@"确认收货中..."];
        [MyPageHttpTool confirmGetProduct:orderId withCompleted:^(id result, BOOL success) {
            if (success) {
                if (weakSelf.needRefreshBlock) {
                    weakSelf.needRefreshBlock();
                }
                [weakSelf showSuccessMsg:@"确认收货成功"];
                [weakSelf.navigationController popViewControllerAnimated:true];
                
            }else{
                [weakSelf showErrorMsg:result];
            }
        }];
        
    }];
    

}







@end
