//
//  MyPageLogoutAndForgetPsCell.m
//  me
//
//  Created by KLP on 2018/1/25.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyPageLogoutAndForgetPsCell.h"

@interface MyPageLogoutAndForgetPsCell()
@property (weak, nonatomic) IBOutlet UIButton *changePsBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end

@implementation MyPageLogoutAndForgetPsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.changePsBtn.layer.cornerRadius = 5.0;
    self.changePsBtn.layer.masksToBounds = YES;
    self.changePsBtn.layer.borderColor = _mainColor.CGColor;
    self.changePsBtn.layer.borderWidth = 1.0;
    
    self.logoutBtn.layer.cornerRadius = 5.0;
    self.logoutBtn.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)changePsBtnClick:(UIButton *)sender {
    if (self.changePsBlock) {
        self.changePsBlock();
    }
}

- (IBAction)logoutBtnClick:(UIButton *)sender {
    if (self.logoutBlock) {
        self.logoutBlock();
    }
}




@end
