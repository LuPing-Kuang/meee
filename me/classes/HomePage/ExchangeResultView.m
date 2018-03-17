//
//  ExchangeResultView.m
//  me
//
//  Created by 邝路平 on 2018/3/14.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ExchangeResultView.h"

@interface ExchangeResultView()
@property (weak, nonatomic) IBOutlet UIImageView *resultImageV;
@property (weak, nonatomic) IBOutlet UILabel *resultLb;
@property (weak, nonatomic) IBOutlet UILabel *resultMsgLb;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,assign) BOOL success;

@end

@implementation ExchangeResultView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.sureBtn.layer.cornerRadius = 5.0;
    self.sureBtn.layer.masksToBounds = YES;
    self.success = NO;
    
}


- (void)showSuccess {
    
    self.success = YES;
    
    self.resultImageV.image = [UIImage imageNamed:@"成功"];
    self.resultLb.text = @"兑换成功";
    self.resultMsgLb.text = @"余额已兑换成功";
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
}

- (void)showError {
    self.success = NO;
    
    self.resultImageV.image = [UIImage imageNamed:@"失败"];
    self.resultLb.text = @"无效二维码";
    self.resultMsgLb.text = @"此兑换码不正确或不存在";
    [self.sureBtn setTitle:@"重新扫描" forState:UIControlStateNormal];
}


- (IBAction)sureBtnClick:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock(self.success);
    }
    
}




@end
