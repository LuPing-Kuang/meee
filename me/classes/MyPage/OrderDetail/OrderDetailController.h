//
//  OrderDetailController.h
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//


#import "BaseToolBarTableViewController.h"
@interface OrderDetailController : BaseToolBarTableViewController
@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,copy) void(^needRefreshBlock)(void);


@end
