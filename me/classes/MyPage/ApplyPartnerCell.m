//
//  ApplyPartnerCell.m
//  me
//
//  Created by KLP on 2018/1/24.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ApplyPartnerCell.h"

@implementation ApplyPartnerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.applyBtn.layer.cornerRadius = 5.0;
    self.applyBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


- (IBAction)applyBtnClick:(UIButton *)sender {
    if (self.applyBlock) {
        self.applyBlock();
    }
}



@end
