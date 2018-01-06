//
//  MyHeaderTableViewCell.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyHeaderTableViewCell.h"

@implementation MyHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headBgView.clipsToBounds=YES;
    self.headBgView.layer.cornerRadius=self.headBgView.frame.size.width/2;
    
    self.headImageView.clipsToBounds=YES;
    self.headImageView.layer.cornerRadius=self.headImageView.frame.size.width/2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)settingButton:(id)sender {
}
@end
