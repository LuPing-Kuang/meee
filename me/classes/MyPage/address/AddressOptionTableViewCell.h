//
//  AddressOptionTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductionOrderModel.h"

typedef NS_ENUM(NSInteger,AddressOptionAction)
{
    AddressOptionActionDefault,
    AddressOptionActionEdit,
    AddressOptionActionDelete,
};

@class AddressOptionTableViewCell;

@protocol AddressOptionTableViewCellDelegate <NSObject>

-(void)addressOtionTableViewCell:(AddressOptionTableViewCell*)cell doAction:(AddressOptionAction)action;

@end

@interface AddressOptionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *defaulButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic,strong) ProductionOrderAddressModel* model;

@property (weak,nonatomic) id<AddressOptionTableViewCellDelegate>delegate;

@end
