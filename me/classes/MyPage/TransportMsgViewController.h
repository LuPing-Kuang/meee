//
//  TransportMsgViewController.h
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MyOrderModel.h"

@interface TransportMsgViewController : BaseTableViewController

@property (nonatomic, strong) MyOrderProductModel *productModel;
@property (nonatomic, strong) NSString *orderId;


@end
