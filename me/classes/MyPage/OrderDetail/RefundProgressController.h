//
//  RefundProgressController.h
//  me
//
//  Created by 邝路平 on 2018/4/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaseToolBarTableViewController.h"

@interface RefundProgressController : BaseToolBarTableViewController

@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,copy) void(^needRefreshBlock)(void);

@end
