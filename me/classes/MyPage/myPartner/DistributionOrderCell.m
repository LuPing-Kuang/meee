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

@property (weak, nonatomic) IBOutlet UIImageView *buyerAvatorImageV;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLb;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageV;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLb;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLb;
@property (weak, nonatomic) IBOutlet UILabel *goodsCashLb;


@end

@implementation DistributionOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.orderNumLb.isCopyable = true;
    self.buyerAvatorImageV.layer.cornerRadius = self.buyerAvatorImageV.height_gst/2.0;
    self.buyerAvatorImageV.layer.masksToBounds = true;
}

- (void)setModel:(DistributionOrderModel *)model{
    _model = model;
    self.distributionLevelLb.text = _model.level;
    self.orderNumLb.text = _model.ordersn;
    self.orderTimeLb.text = _model.createtime;
    self.cashLb.text = [NSString stringWithFormat:@"+%@",_model.commission];
}

- (void)setHeaderModel:(BuyerModel *)headerModel{
    _headerModel = headerModel;
    
    if (_headerModel.avatar) {
        [self.buyerAvatorImageV setImageUrl:_headerModel.avatar];
    }else {
        [self.buyerAvatorImageV setImageUrl:_headerModel.avatar_wechat];
    }
    self.nickNameLb.text = _headerModel.nickname;
    
}

- (void)setGoodsModel:(DisOrder_goodsModel *)goodsModel{
    _goodsModel = goodsModel;
    [self.goodsImageV setImageUrl:_goodsModel.thumb];
    self.goodsNameLb.text = _goodsModel.title;
    self.goodsCountLb.text = [NSString stringWithFormat:@"x%@",_goodsModel.total];
    self.goodsCashLb.text = [NSString stringWithFormat:@"+%@",_goodsModel.commission];
    
}



@end
