//
//  ApplyRefundController.h
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaseToolBarTableViewController.h"
#import "RefundPageModel.h"

@interface ApplyRefundController : BaseToolBarTableViewController

@property (nonatomic,assign) BOOL isModify;

@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,copy) void(^needRefreshBlock)(void);

@property (nonatomic,strong) RefundPageModel *pageModel;


@end
