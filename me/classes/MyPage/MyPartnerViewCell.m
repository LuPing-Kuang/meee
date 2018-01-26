//
//  MyPartnerViewCell.m
//  me
//
//  Created by KLP on 2018/1/18.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyPartnerViewCell.h"
#import "DistributionOrderPageController.h"
#import "GetCashDetailPageController.h"
#import "MyOtherPartnerPageController.h"

@interface MyPartnerViewCell()

//头部
@property (weak, nonatomic) IBOutlet UIView *bgHeaderV;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;
@property (weak, nonatomic) IBOutlet UILabel *phoneLb;
@property (weak, nonatomic) IBOutlet UILabel *vipLevelLb;
@property (weak, nonatomic) IBOutlet UILabel *refereesLb;
@property (weak, nonatomic) IBOutlet UILabel *invitationNumLb;
@property (weak, nonatomic) IBOutlet UILabel *cashLb;
@property (weak, nonatomic) IBOutlet UILabel *canGetCashLb;
@property (weak, nonatomic) IBOutlet UILabel *rebateCashLb;


//功能区
@property (weak, nonatomic) IBOutlet UILabel *PartnerCommissionLb;
@property (weak, nonatomic) IBOutlet UILabel *billCountLb;
@property (weak, nonatomic) IBOutlet UILabel *GetCashCountLb;
@property (weak, nonatomic) IBOutlet UILabel *PartnerCountLb;

@end

@implementation MyPartnerViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headerImageV.layer.cornerRadius = self.headerImageV.frame.size.height/2.0;
    self.headerImageV.layer.masksToBounds = YES;
    
    self.rebateCashLb.layer.cornerRadius = self.rebateCashLb.frame.size.height/2.0;
    self.rebateCashLb.layer.masksToBounds = YES;
    self.rebateCashLb.layer.borderColor = [UIColor whiteColor].CGColor;
    self.rebateCashLb.layer.borderWidth = 1.0;
    
    self.vipLevelLb.layer.cornerRadius = self.vipLevelLb.frame.size.height/2.0;
    self.vipLevelLb.layer.masksToBounds = YES;
    self.vipLevelLb.layer.borderColor = [UIColor whiteColor].CGColor;
    self.vipLevelLb.layer.borderWidth = 1.0;
    
    self.bgHeaderV.layer.cornerRadius = self.bgHeaderV.frame.size.height/2.0;
    self.bgHeaderV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPartnerModel:(MyPartnerModel *)partnerModel{
    _partnerModel = partnerModel;
    

    [self.headerImageV setImageUrl:_partnerModel.member.avatar];
    self.phoneLb.text = _partnerModel.member.nickname;
    self.vipLevelLb.text = [NSString stringWithFormat:@"  %@  ",_partnerModel.levelname];
    self.refereesLb.text = [NSString stringWithFormat:@"推荐人:%@",_partnerModel.agentname];   //调试中
    self.invitationNumLb.text = [NSString stringWithFormat:@"邀请码:%@",_partnerModel.icode];
    self.cashLb.text = _partnerModel.member.commission_pay;
    self.canGetCashLb.text = _partnerModel.member.commission_ok;
    
    self.PartnerCommissionLb.attributedText = [self colorStr:_partnerModel.member.commission_total LastStr:@"元"];
    self.billCountLb.attributedText = [self colorStr:_partnerModel.member.ordercount0 LastStr:@"笔"];
    self.GetCashCountLb.attributedText = [self colorStr:_partnerModel.member.applycount LastStr:@"笔"];
    self.PartnerCountLb.attributedText = [self colorStr:_partnerModel.member.downcount LastStr:@"人"];
    
}



//合伙人佣金
- (IBAction)PartnerCommissionBtnClick:(UIButton *)sender {
    
    //调试中
    [self.viewController.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"DistributionCashController"] animated:YES];
}


//佣金明细
- (IBAction)CommissionDetailBtnClick:(UIButton *)sender {
    
    DistributionOrderPageController* pag=[[DistributionOrderPageController alloc]init];
    pag.originalPageIndex=0;
    [self.viewController.navigationController pushViewController:pag animated:YES];
}

//我的合伙人
- (IBAction)MyPartnerBtnClick:(UIButton *)sender {
    MyOtherPartnerPageController* pag=[[MyOtherPartnerPageController alloc]init];
    pag.title = [NSString stringWithFormat:@"我的下线(%@)",_partnerModel.member.downcount];
    [self.viewController.navigationController pushViewController:pag animated:YES];
}




//提现明细
- (IBAction)CashDetailBtnClick:(UIButton *)sender {
    GetCashDetailPageController* pag=[[GetCashDetailPageController alloc]init];
    pag.originalPageIndex=0;
    [self.viewController.navigationController pushViewController:pag animated:YES];
}

//去设置
- (IBAction)setttingBtnClick:(UIButton *)sender {
    
}



- (NSMutableAttributedString*)colorStr:(NSString*)startstr LastStr:(NSString*)lastStr{
    
    NSString *str = [NSString stringWithFormat:@"%@%@",startstr,lastStr];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:str];
    [string addAttributes:@{NSForegroundColorAttributeName:_importantColor} range:NSMakeRange(0, startstr.length)];
    
    return string;
}


@end
