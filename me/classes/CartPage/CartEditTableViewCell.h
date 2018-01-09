//
//  CartEditTableViewCell.h
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZStepper.h"

#import "CartItemModel.h"

@class CartEditTableViewCell;

@protocol CartEditTableViewCellDelegate <NSObject>

-(void)cartEditTableViewCell:(CartEditTableViewCell *)cell didChangeModelSelection:(CartItemModel *)cartModel;
-(void)cartEditTableViewCell:(CartEditTableViewCell *)cell didChangeModelCount:(CartItemModel *)cartModel;

@end

@interface CartEditTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *optionButton;
@property (weak, nonatomic) IBOutlet UIImageView *optionArrow;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet ZZStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (strong,nonatomic) CartItemModel* cartModel;
@property (weak,nonatomic) id<CartEditTableViewCellDelegate> delegate;

@end
