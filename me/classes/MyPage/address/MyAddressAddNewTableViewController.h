//
//  MyAddressAddNewTableViewController.h
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ProductionOrderModel.h"

@interface MyAddressAddNewTableViewController : BaseTableViewController

@property (nonatomic, copy) void(^refreshBlock)(void);

@property (nonatomic, strong) ProductionOrderAddressModel *addressModel;


@end
