//
//  ApplyPartnerCell.h
//  me
//
//  Created by KLP on 2018/1/24.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyPartnerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *inviteTf;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *weixinTf;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet UILabel *checkLb;



@property (nonatomic, copy) void(^applyBlock)(void);
@property (nonatomic, copy) void(^checkBlock)(void);


@end
