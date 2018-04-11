//
//  MyOrderListTableViewCell.m
//  me
//
//  Created by jam on 2018/1/12.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOrderListTableViewCell.h"

@implementation MyOrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.productImage.layer.masksToBounds = YES;
    self.orderNumber.isCopyable = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    
    for (UIView* sub in self.contentView.subviews) {
        sub.tag=tag;
    }
}

@end
