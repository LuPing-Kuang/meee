//
//  changePsCell.m
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "changePsCell.h"

@interface changePsCell()
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation changePsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.sureBtn.layer.cornerRadius = 6.0;
    self.sureBtn.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)sureBtnClick:(UIButton *)sender {
    
    if (self.sureBlock) {
        self.sureBlock();
    }
    
}

- (IBAction)codeBtnClick:(UIButton *)sender {
    
    if (self.codeBlock) {
        self.codeBlock();
    }
}


@end
