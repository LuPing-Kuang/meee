//
//  GetCashCell.h
//  me
//
//  Created by 邝路平 on 2018/3/17.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetCashCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *canGetCashLb;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *getCashMsgLb;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLb;
@property (weak, nonatomic) IBOutlet UITextField *itemTf;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;


@property (nonatomic,copy) void(^sureBlock)(void);
@property (nonatomic,copy) void(^selectBlock)(NSInteger index);


- (void)showBank;
- (void)hideBank;

@property (nonatomic, copy) void(^textChangeBlock)(NSString *text);


@end
