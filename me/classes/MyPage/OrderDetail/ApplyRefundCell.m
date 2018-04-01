//
//  ApplyRefundCell.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ApplyRefundCell.h"

@implementation ApplyRefundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (IBAction)itemBtnClick:(UIButton *)sender {
    
    CGRect rect = [self convertRect:self.itemBtn.frame toView:self.viewController.view];
    
    if (self.itemBtnClick) {
        self.itemBtnClick(rect);
    }
    
}


- (IBAction)RefundDescriptionTfDicChange:(UITextField *)sender {
    if (self.RefundDesDidChange) {
        self.RefundDesDidChange(sender.text);
    }
    
}

- (IBAction)RefundMoneyTfDidChange:(UITextField *)sender {
    if (self.RefundMoneyDidChange) {
        self.RefundMoneyDidChange(sender.text);
    }
}

- (IBAction)ImageBtnClick:(UIButton *)sender {
    if (self.imageBtnClick) {
        self.imageBtnClick();
    }
    
    
}








@end
