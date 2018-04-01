//
//  DistributionCashCell.h
//  me
//
//  Created by KLP on 2018/1/18.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistributionCashCell : UITableViewCell

//头部
@property (weak, nonatomic) IBOutlet UILabel *totalCashLb;

//中间
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLb;
@property (weak, nonatomic) IBOutlet UILabel *cashLb;

//尾部
@property (weak, nonatomic) IBOutlet UILabel *footerTipsLb;


@end
