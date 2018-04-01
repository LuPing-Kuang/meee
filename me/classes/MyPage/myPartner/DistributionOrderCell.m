//
//  DistributionOrderCell.m
//  me
//
//  Created by KLP on 2018/1/19.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "DistributionOrderCell.h"

@interface DistributionOrderCell()

@property (weak, nonatomic) IBOutlet UILabel *distributionLevelLb;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLb;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *cashLb;

@end

@implementation DistributionOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(DistributionOrderModel *)model{
    _model = model;
    self.distributionLevelLb.text = _model.level;
    self.orderNumLb.text = _model.ordersn;
    self.orderTimeLb.text = _model.createtime;
    self.cashLb.text = [NSString stringWithFormat:@"+%@",_model.commission];
}



@end
