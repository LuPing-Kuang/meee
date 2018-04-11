//
//  RefundProgressCell.h
//  me
//
//  Created by 邝路平 on 2018/4/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundProgressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *merchantTipsLb;
@property (weak, nonatomic) IBOutlet UILabel *tipsDetailLb;

@property (weak, nonatomic) IBOutlet UILabel *itemNameLb;
@property (weak, nonatomic) IBOutlet UILabel *itemMsgLb;



@end
