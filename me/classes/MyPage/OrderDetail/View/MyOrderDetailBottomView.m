//
//  MyOrderDetailBottomView.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOrderDetailBottomView.h"

@interface  MyOrderDetailBottomView()

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;

@end

@implementation MyOrderDetailBottomView


- (void)awakeFromNib{
    [super awakeFromNib];
}


- (void)setTitleArr:(NSArray *)titleArr{
    
    _titleArr = titleArr;
    if (_titleArr.count == 1) {
        self.secondBtn.hidden = true;
        self.firstBtn.hidden = false;
        
        NSString *Str = [NSString stringWithFormat:@"   %@   ",_titleArr.firstObject];
        [self.firstBtn setTitle:Str forState:UIControlStateNormal];
        self.firstBtn.layer.cornerRadius = self.firstBtn.bounds.size.height/2.0;
        self.firstBtn.layer.borderWidth = 1.0;
        self.firstBtn.layer.borderColor = UIColor.darkGrayColor.CGColor;
        
        
    }else if (_titleArr.count == 2) {
        
        self.secondBtn.hidden = false;
        self.firstBtn.hidden = false;
        
        NSString *Str1 = [NSString stringWithFormat:@"   %@   ",_titleArr.firstObject];
        [self.firstBtn setTitle:Str1 forState:UIControlStateNormal];
        self.firstBtn.layer.cornerRadius = self.firstBtn.bounds.size.height/2.0;
        self.firstBtn.layer.borderWidth = 1.0;
        self.firstBtn.layer.borderColor = UIColor.darkGrayColor.CGColor;
        
        NSString *Str = [NSString stringWithFormat:@"   %@   ",_titleArr.lastObject];
        [self.secondBtn setTitle:Str forState:UIControlStateNormal];
        self.secondBtn.layer.cornerRadius = self.secondBtn.bounds.size.height/2.0;
        self.secondBtn.layer.borderWidth = 1.0;
        self.secondBtn.layer.borderColor = UIColor.darkGrayColor.CGColor;
        
    }
    
}


- (void)setFirstColorTitleArr:(NSArray *)firstColorTitleArr{
    _firstColorTitleArr = firstColorTitleArr;
    
    if (_firstColorTitleArr.count == 2) {
        
        
        self.firstBtn.hidden = false;
        self.secondBtn.hidden = false;
        
        NSString *Str1 = [NSString stringWithFormat:@"   %@   ",_firstColorTitleArr.firstObject];
        [self.firstBtn setTitle:Str1 forState:UIControlStateNormal];
        self.firstBtn.layer.cornerRadius = self.firstBtn.bounds.size.height/2.0;
        self.firstBtn.layer.borderWidth = 1.0;
        self.firstBtn.layer.borderColor = UIColor.darkGrayColor.CGColor;
        
        NSString *Str = [NSString stringWithFormat:@"   %@   ",_firstColorTitleArr.lastObject];
        [self.secondBtn setTitle:Str forState:UIControlStateNormal];
        self.secondBtn.layer.cornerRadius = self.secondBtn.bounds.size.height/2.0;
        self.secondBtn.layer.borderWidth = 1.0;
        self.secondBtn.layer.borderColor = _redColor.CGColor;
        [self.secondBtn setTitleColor:_redColor forState:UIControlStateNormal];
        
        
    }
    
    
}


- (IBAction)firstBtnClick:(UIButton *)sender {
    
    if (self.selectBlock) {
        self.selectBlock(0);
    }
    
}

- (IBAction)secondBtnClick:(UIButton *)sender {
    
    if (self.selectBlock) {
        self.selectBlock(1);
    }
}


@end
