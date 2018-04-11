//
//  DistributionOrderCell.h
//  me
//
//  Created by KLP on 2018/1/19.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DistributionOrderModel.h"

@interface DistributionOrderCell : UITableViewCell

@property (nonatomic, strong) DistributionOrderModel *model;

@property (nonatomic, strong) BuyerModel *headerModel;

@property (nonatomic, strong) DisOrder_goodsModel *goodsModel;

@end
