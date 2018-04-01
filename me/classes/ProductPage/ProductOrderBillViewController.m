//
//  ProductOrderBillViewController.m
//  me
//
//  Created by jam on 2018/1/12.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductOrderBillViewController.h"
#import "ProductPageHttpTool.h"
#import "ProductionPayTypeModel.h"
#import "ProductPaySuccessController.h"

@interface ProductOrderBillViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (weak, nonatomic) IBOutlet UILabel *myBalance;

@property (nonatomic, strong) ProductionPayTypeModel *model;

@property (nonatomic,assign) BOOL ishasData;

@end

@implementation ProductOrderBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收银台";
    self.ishasData = false;
    [self refresh];
}


- (void)refresh{
    MJWeakSelf;
    [ProductPageHttpTool payOrderWithOrderNum:self.orderId withCompleted:^(id result, BOOL success) {
        if (success) {
            weakSelf.model = result;
            weakSelf.ishasData = true;
            [weakSelf.tableView reloadData];
            [weakSelf endRefresh];
        }else{
            [weakSelf showErrorMsg:result];
        }
        
    }];
}

- (void)setModel:(ProductionPayTypeModel *)model{
    _model = model;
    
    self.orderNumber.text = _model.ordersn;
    self.orderPrice.text = [NSString stringWithFormat:@"¥ %@",_model.price];
    self.myBalance.text = [NSString stringWithFormat:@"¥ %@",_model.credit.current];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.ishasData) {
        return 2;
    }else{
        return 0;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        if (self.model.credit.success) {
            MJWeakSelf;
            [self showSystemAlertWithTitle:@"提醒" message:@"确认要支付吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
                
            } btnBlock:^(UIAlertAction *action) {
                [weakSelf payWithPayType:@"credit"];
            }];
            
        }
    }else if (indexPath.row==1){
        if (self.model.wechat.success) {
            MJWeakSelf;
            [self showSystemAlertWithTitle:@"提醒" message:@"确认要支付吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
                
            } btnBlock:^(UIAlertAction *action) {
                [weakSelf payWithPayType:@"wechat"];
            }];
            
        }
    }else if (indexPath.row==2){
        if (self.model.alipay.success) {
            MJWeakSelf;
            [self showSystemAlertWithTitle:@"提醒" message:@"确认要支付吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
                
            } btnBlock:^(UIAlertAction *action) {
                [weakSelf payWithPayType:@"alipay"];
            }];
        }
    }
}


- (void)payWithPayType:(NSString*)payType{
    MJWeakSelf;
    [self showLoading:@"支付中..."];
    [ProductPageHttpTool checkOrderWithOrderNum:self.orderId withCompleted:^(id result, BOOL success) {
        if (success) {
            
            if ([payType isEqualToString:@"credit"]) {
                
                [ProductPageHttpTool payWithOrdersn:self.model.ordersn WithOrderNum:self.orderId withCompleted:^(id result, BOOL success) {
                    
                    if (success) {
                        [weakSelf showSuccessMsg:@"余额支付成功"];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_RefreshMoney_Notification object:nil];
                        
                        ProductPaySuccessController* vc=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductPaySuccessController"];
                        vc.orderId = weakSelf.orderId;
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }else{
                        [weakSelf showErrorMsg:@"余额不足,请充值"];
                    }
                    
                }];
                
            }else{
                
                [ProductPageHttpTool getPayRequestWithtype:payType WithOrderNum:weakSelf.orderId withCompleted:^(id result, BOOL success) {
                    if (success) {
                        [weakSelf stopAnimation];
                        BaseWebViewController *vc = [[BaseWebViewController alloc]initWithUrl:[NSURL URLWithString:result]];
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                        vc.isNeedQuery = YES;
                        vc.orderId = weakSelf.orderId;
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_RefreshMoney_Notification object:nil];
                        
                    }else{
                        [weakSelf showErrorMsg:result];
                    }
                    
                }];
            }
        }else{
            [weakSelf showErrorMsg:result];
        }
        
    }];
    
}


@end
