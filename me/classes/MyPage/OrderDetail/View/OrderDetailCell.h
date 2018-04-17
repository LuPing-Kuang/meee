//
//  OrderDetailCell.h
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyOrderDetailModel.h"

@interface OrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLb;

@property (weak, nonatomic) IBOutlet UILabel *namePhoneLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;

@property (weak, nonatomic) IBOutlet UIImageView *productImageV;
@property (weak, nonatomic) IBOutlet UILabel *productNameLb;
@property (weak, nonatomic) IBOutlet UILabel *productOptionLb;
@property (weak, nonatomic) IBOutlet UILabel *productMoneyLb;
@property (weak, nonatomic) IBOutlet UILabel *productNumLb;

@property (weak, nonatomic) IBOutlet UILabel *goodspriceLb;
@property (weak, nonatomic) IBOutlet UILabel *dispatchpriceLb;
@property (weak, nonatomic) IBOutlet UILabel *TotalPriceLb;


@property (weak, nonatomic) IBOutlet UILabel *orderNumLb;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *deliveryTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *finishTimeLb;

@property (weak, nonatomic) IBOutlet UILabel *remarkLb;


@property (nonatomic,strong) OrderGoodDetailModel *goodModel;


@property (nonatomic,copy) void(^addressBlock)(void);


@end
