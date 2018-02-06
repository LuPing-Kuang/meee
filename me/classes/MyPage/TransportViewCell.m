//
//  TransportViewCell.m
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "TransportViewCell.h"

@implementation TransportViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.countLb.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)lookBtnClick:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock(_productModel);
    }
}

- (void)setProductModel:(MyOrderProductModel *)productModel{
    _productModel = productModel;
}

@end
