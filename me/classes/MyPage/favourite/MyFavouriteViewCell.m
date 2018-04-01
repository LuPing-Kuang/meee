//
//  MyFavouriteViewCell.m
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyFavouriteViewCell.h"
@interface MyFavouriteViewCell()


@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentVLeadingConstraint;

@end

@implementation MyFavouriteViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMyfavouriteModel:(MyfavouriteModel *)myfavouriteModel{
    _myfavouriteModel = myfavouriteModel;
    
    [self.image setImageUrl:_myfavouriteModel.thumb];
    self.title.text = _myfavouriteModel.title;
    self.price1.text = [NSString stringWithFormat:@"¥%@",_myfavouriteModel.marketprice];
    NSString *price2 = [NSString stringWithFormat:@"¥%@",_myfavouriteModel.productprice];
    NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc]initWithString:price2];
    [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, price2.length)];
    
    self.price2.attributedText = newPrice;
    
    if (_myfavouriteModel.isSelected) {
        self.selectButton.selected = YES;
    }else{
        self.selectButton.selected = NO;
    }
    
}


- (void)showSelectBtn{
    self.selectButton.hidden = NO;
    self.contentVLeadingConstraint.constant = 50;
}


- (void)hideSelectBtn{
    self.selectButton.hidden = YES;
    self.contentVLeadingConstraint.constant = 15;
}

- (IBAction)selectBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    _myfavouriteModel.isSelected = sender.selected;
    
    if (self.selectBlock) {
        self.selectBlock(_myfavouriteModel);
    }
}




@end
