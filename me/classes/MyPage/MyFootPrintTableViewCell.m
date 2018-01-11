//
//  MyFootPrintTableViewCell.m
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyFootPrintTableViewCell.h"

@interface MyFootPrintTableViewCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingToSelectButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingToSuperView;


@end

@implementation MyFootPrintTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEditing:(BOOL)editing
{
//    BOOL oldEd=self.editing;
    [super setEditing:editing];
    
//    if (oldEd==editing) {
//        return;
//    }
    
    self.selectButton.hidden=!editing;
    
    if (editing) {
        self.leadingToSuperView.active=!editing;
        self.leadingToSelectButton.active=editing;
    }
    else
    {
        self.leadingToSelectButton.active=editing;
        self.leadingToSuperView.active=!editing;
    }
    
////    [self.contentView layoutIfNeeded];
//    [UIView animateWithDuration:0.25 animations:^{
//        // Make all constraint changes here
//        [self.contentView layoutIfNeeded];
//    }];
}

@end
