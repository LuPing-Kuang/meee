//
//  ApplyRefundCell.h
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyRefundCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemNameLb;
@property (weak, nonatomic) IBOutlet UILabel *itemMsglb;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn;
@property (weak, nonatomic) IBOutlet UITextField *RefundMoneyTf;
@property (weak, nonatomic) IBOutlet UITextField *RefundDescriptionTf;
@property (weak, nonatomic) IBOutlet UIButton *ImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *RefundTipsLb;


@property (nonatomic,copy) void(^RefundDesDidChange)(NSString *text);
@property (nonatomic,copy) void(^RefundMoneyDidChange)(NSString *text);

@property (nonatomic,copy) void(^itemBtnClick)(CGRect rect);
@property (nonatomic,copy) void(^imageBtnClick)(void);


@end
