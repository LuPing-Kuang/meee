//
//  PartnerMaterialCell.m
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "PartnerMaterialCell.h"

@implementation PartnerMaterialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.saveBtn.layer.cornerRadius = 5.0;
    self.saveBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sureBtnClick:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock();
    }
}

- (IBAction)saveBtnClick:(UIButton *)sender {
    if (self.saveBlock) {
        self.saveBlock();
    }
}


- (IBAction)textfieldDidChange:(UITextField *)sender {
    
    if (self.textChangeBlock) {
        self.textChangeBlock(sender.text);
    }
    
}


@end
