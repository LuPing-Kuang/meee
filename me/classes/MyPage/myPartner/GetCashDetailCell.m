//
//  GetCashDetailCell.m
//  me
//
//  Created by KLP on 2018/1/19.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "GetCashDetailCell.h"
#import "GetCashRealDetailController.h"

@interface GetCashDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *cashToLb;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *commissionLb;
@property (weak, nonatomic) IBOutlet UILabel *realMoneyLb;
@property (weak, nonatomic) IBOutlet UILabel *deductionmoneyLb;



@end

@implementation GetCashDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(GetCashDetailModel *)model{
    _model = model;
    NSString *cashToStr = @"";
    if ([_model.type isEqualToString:@"0"]) {
        cashToStr = @"提现到余额";
    }else if ([_model.type isEqualToString:@"1"]){
        cashToStr = @"提现到微信红包";
    }else if ([_model.type isEqualToString:@"2"]){
        cashToStr = @"提现到支付宝";
    }else if ([_model.type isEqualToString:@"3"]){
        cashToStr = @"提现到银行卡";
    }
    
    self.cashToLb.text = cashToStr;
    self.payTimeLb.text = _model.dealtime;
    self.moneyLb.text = [NSString stringWithFormat:@"+%@",_model.commission_pay];
    self.statusLb.text = _model.statusstr;
    self.commissionLb.text = _model.commission;
    self.realMoneyLb.text = _model.realmoney;
    self.deductionmoneyLb.text = [NSString stringWithFormat:@"%@元",_model.deductionmoney];
    
}

- (IBAction)showDetailBtnClick:(UIButton *)sender {
    
    GetCashRealDetailController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"GetCashRealDetailController"];
    vc.orderId = self.model.ID;
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}



@end
