//
//  MyOtherPartnerCell.m
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOtherPartnerCell.h"

@interface MyOtherPartnerCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLb;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *commission_totalLb;
@property (weak, nonatomic) IBOutlet UILabel *orderLb;


@end

@implementation MyOtherPartnerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageV.layer.cornerRadius = self.iconImageV.bounds.size.height/2.0;
    self.iconImageV.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MyOtherPartnerModel *)model{
    _model = model;
    [self.iconImageV setImageUrl:_model.avatar];
    self.nickNameLb.text = _model.nickname;
    self.createTimeLb.text = [NSString stringWithFormat:@"注册时间:%@",_model.createtime];
    self.commission_totalLb.text = [NSString stringWithFormat:@"消费:%@元",_model.commission_total];
    self.orderLb.text = [NSString stringWithFormat:@"%@个订单",_model.ordercount];
}

@end
