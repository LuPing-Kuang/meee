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

@interface ProductOrderBillViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (weak, nonatomic) IBOutlet UILabel *myBalance;

@property (nonatomic, strong) ProductionPayTypeModel *model;


@end

@implementation ProductOrderBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收银台";
    
    [self refresh];
}


- (void)refresh{
    MJWeakSelf;
    [ProductPageHttpTool payOrderWithOrderNum:self.orderId withCompleted:^(id result, BOOL success) {
        if (success) {
            weakSelf.model = result;
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
            [self payWithPayType:@"credit"];
        }else{
            
        }
    }else if (indexPath.row==1){
        if (self.model.wechat.success) {
            [self payWithPayType:@"wechat"];
        }else{
            
        }
    }else if (indexPath.row==2){
        if (self.model.alipay.success) {
            [self payWithPayType:@"alipay"];
        }else{
            
        }
    }
}


- (void)payWithPayType:(NSString*)payType{
    MJWeakSelf;
    [self showLoading:@"加载中..."];
    [ProductPageHttpTool checkOrderWithOrderNum:self.orderId withCompleted:^(id result, BOOL success) {
        if (success) {
            
            if ([payType isEqualToString:@"credit"]) {
                
                [ProductPageHttpTool payWithOrdersn:self.model.ordersn WithOrderNum:self.orderId withCompleted:^(id result, BOOL success) {
                    
                    if (success) {
                        [weakSelf showSuccessMsg:@"余额支付成功"];
                        
                        UIViewController* vc=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductPaySuccessController"];
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
