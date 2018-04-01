//
//  GetCashCell.m
//  me
//
//  Created by 邝路平 on 2018/3/17.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "GetCashCell.h"


@interface GetCashCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconLeadingConstraint;



@end

@implementation GetCashCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nextBtn.layer.cornerRadius = 5.0;
    self.nextBtn.layer.masksToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}


- (void)showBank{
    self.iconImageV.hidden = NO;
    self.iconLeadingConstraint.constant = 15;
}

- (void)hideBank{
    self.iconImageV.hidden = YES;
    self.iconLeadingConstraint.constant = -25.0;
}




- (IBAction)selectBtnClick:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock(self.selectBtn.tag);
    }
}


- (IBAction)textfieldDidChange:(UITextField *)sender {
    
    if (self.textChangeBlock) {
        self.textChangeBlock(sender.text);
    }
    
}



- (IBAction)nextBtnClick:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock();
    }
}



@end
