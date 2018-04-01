//
//  MyOrderListTableViewCell.h
//  me
//
//  Created by jam on 2018/1/12.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *productOption;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productCount;

@property (weak, nonatomic) IBOutlet UILabel *orderTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalCount;

@property (weak, nonatomic) IBOutlet UIButton *orderButtonCancel;
@property (weak, nonatomic) IBOutlet UIButton *orderButtonPay;
@property (weak, nonatomic) IBOutlet UIButton *orderButtonDelete;
@property (weak, nonatomic) IBOutlet UIButton *orderButtonTransport;
@property (weak, nonatomic) IBOutlet UIButton *orderButtonComfirm;

@end
