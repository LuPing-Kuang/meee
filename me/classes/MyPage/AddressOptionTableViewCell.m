//
//  AddressOptionTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "AddressOptionTableViewCell.h"

@implementation AddressOptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)defaultClick:(id)sender {
//    self.defaulButton.selected=!self.defaulButton.selected;
//    self.defaulButton.selected=YES;
    [self doAction:AddressOptionActionDefault];
}

- (IBAction)deleteClick:(id)sender {
    [self doAction:AddressOptionActionDelete];
}

- (IBAction)editClick:(id)sender {
    [self doAction:AddressOptionActionEdit];
}
     
-(void)doAction:(AddressOptionAction)action
{
    if ([self.delegate respondsToSelector:@selector(addressOtionTableViewCell:doAction:)]) {
        [self.delegate addressOtionTableViewCell:self doAction:action];
    }
}

@end
