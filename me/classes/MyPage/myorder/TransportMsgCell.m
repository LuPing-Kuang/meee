//
//  TransportMsgCell.m
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "TransportMsgCell.h"

@implementation TransportMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.dotV.layer.cornerRadius = self.dotV.frame.size.height/2.0;
    self.dotV.layer.masksToBounds = YES;
    self.productCountLb.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
