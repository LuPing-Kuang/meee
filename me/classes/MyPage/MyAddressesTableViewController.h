//
//  MyAddressesTableViewController.h
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaseToolBarTableViewController.h"

@class MyAddressesTableViewController;
@class ProductionOrderAddressModel;

@protocol MyAddressesTableViewControllerDelegate <NSObject>

@optional
-(void)myAddressesTableViewController:(MyAddressesTableViewController*)controller didSelectedAddress:(ProductionOrderAddressModel*)address;

@end

@interface MyAddressesTableViewController : BaseToolBarTableViewController

@property (nonatomic,weak) id<MyAddressesTableViewControllerDelegate> delegate;

@end
