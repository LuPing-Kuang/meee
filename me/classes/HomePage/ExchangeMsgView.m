//
//  ExchangeMsgView.m
//  me
//
//  Created by 邝路平 on 2018/3/14.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ExchangeMsgView.h"

@interface ExchangeMsgView ()
@property (weak, nonatomic) IBOutlet UILabel *exchangeNumLb;
@property (weak, nonatomic) IBOutlet UILabel *exchangeMsglb;
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *contentV;

@end

@implementation ExchangeMsgView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupSubViews];
    
}

- (void)setupSubViews {
    self.contentV.layer.cornerRadius = 8.0;
    self.contentV.layer.masksToBounds = YES;
    [self.contentV addDefaultShadow];
    
    self.exchangeBtn.layer.cornerRadius = 5.0;
    self.exchangeBtn.layer.masksToBounds = YES;
    
    self.backBtn.layer.cornerRadius = 5.0;
    self.backBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.backBtn.layer.borderWidth = 1.0;
    
}

- (IBAction)backBtnClick:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}

- (IBAction)exchangeBtnClick:(UIButton *)sender {
    if (self.exchangeBlock && self.model) {
        self.exchangeBlock();
    }
}


- (void)setModel:(exchangeModel *)model{
    _model = model;
    
    self.exchangeNumLb.text = [NSString stringWithFormat:@"兑换码:%@",_model.key];
    self.exchangeMsglb.text = [NSString stringWithFormat:@"此兑换码已查询%@次",_model.count];
    self.moneyLb.text = [NSString stringWithFormat:@"面值:%@元",_model.val];
    
}









@end
