//
//  ProductOrderBillCell.h
//  me
//
//  Created by KLP on 2018/2/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductOrderBillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *payTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *payMsgLb;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLb;

@end
