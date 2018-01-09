//
//  CartEditTableViewCell.m
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "CartEditTableViewCell.h"

@implementation CartEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.editing=self.editing;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)toggleSelected:(id)sender {
    BOOL sele=!(self.cartModel.selected.boolValue);
    self.cartModel.selected=[NSNumber numberWithBool:sele];
    self.selectButton.selected=sele;
    if ([self.delegate respondsToSelector:@selector(cartEditTableViewCell:didChangeModelSelection:)]) {
        [self.delegate cartEditTableViewCell:self didChangeModelSelection:self.cartModel];
    }
}

- (IBAction)countStepperValueChanged:(ZZStepper*)sender {
    self.cartModel.total=[NSNumber numberWithInteger:sender.value];
    self.countLabel.text=[NSString stringWithFormat:@"x%ld",(long)sender.value];
    if ([self.delegate respondsToSelector:@selector(cartEditTableViewCell:didChangeModelCount:)]) {
        [self.delegate cartEditTableViewCell:self didChangeModelCount:self.cartModel];
    }
}


- (IBAction)optionButtonClick:(id)sender {
    
}

-(void)setEditing:(BOOL)editing
{
    [super setEditing:editing];
    self.stepper.hidden=!editing;
    self.countLabel.hidden=editing;
}

@end
