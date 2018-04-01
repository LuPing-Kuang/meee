//
//  MyOrderCollectionTableViewCell.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOrderCollectionTableViewCell.h"

@implementation MyOrderCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setButtons:(NSArray<SimpleButtonModel *> *)buttons
{
    self.buttonsView.buttons=buttons;
    
    self.heightConstraint.constant=[SimpleButtonsTableViewCell heightWithButtonsCount:buttons.count];
}

-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate
{
    self.buttonsView.delegate=delegate;
}

@end
